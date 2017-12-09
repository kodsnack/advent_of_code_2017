{-# LANGUAGE ScopedTypeVariables #-}
-- |
module Seven where

import qualified Text.ParserCombinators.ReadP as P
import qualified Data.Char as Char
import Data.Either (partitionEithers)
import qualified Data.List as List
import Data.Function (on)

import Data.Tree (Tree)
import qualified Data.Tree as Tree

import Data.Map (Map)
import qualified Data.Map as Map

import qualified Data.Set as Set

getRoot :: Map String (Int, [String]) -> String
getRoot m = one . Set.toList $ Map.keysSet m Set.\\ children
  where
    one [x] = x
    one _ = error "there can be only one root."
    children = Map.foldr (\(_, childs) s -> s `Set.union` Set.fromList childs) Set.empty m

type Lbl = (String, Int)

mkTree :: Map String (Int, [String]) -> Tree Lbl
mkTree m = treeMap Map.! getRoot m
  where
    treeMap = flip Map.mapWithKey m $ \me (w, cs) ->
      Tree.Node (me, w) . map (treeMap Map.!) $ cs -- lazyness saves the day!


-- Lots of terrible partiality here, but the constriants of the challenge make it correct.
sol2 :: Tree Lbl -> Int
sol2 t = (\(Left x) -> x) . flip Tree.foldTree t $ \(_, w) cs ->
  let (ml, rs) = partitionEithers cs
  in case ml of
    [x] -> Left x -- exactly one wrong node
    _ -> case uniqueWrong rs of
      Nothing -> Right (w, w + sumWeight rs)
      Just x -> Left x
  where
    sumWeight = sum . map snd
    uniqueWrong rs =
      if length rs < 3 -- if less than 3 childs nothing there cannot be a unique node wrong
      then Nothing
      else
        oneOrTwo .
        List.sortOn length .
        List.groupBy ((==) `on` snd) .
        List.sortOn snd $
        rs

    oneOrTwo [_] = Nothing
    oneOrTwo [((w, this):_), ((_, other):_)] = Just (w + other - this)
    oneOrTwo _ = error "this cannot happen"

main = do
  raw_inp <- readFile "input7.txt"
  let inp = parseInput raw_inp
  print ("p1", getRoot inp)
  print ("p2", sol2 (mkTree inp))

parseLine :: P.ReadP (String, (Int, [String]))
parseLine = do
  me <- name
  P.skipSpaces
  weight :: Int <- P.between (P.string "(") (P.string ")") (read <$> P.munch1 Char.isDigit)
  above <- P.option [] $ do
    P.skipSpaces
    P.string "->"
    P.skipSpaces
    P.sepBy name (P.string ", ")
  pure (me, (weight, above))
  where
    name = P.munch1 Char.isAlpha

runParser :: P.ReadP a -> String -> a
runParser p = fst . last . P.readP_to_S p

parseInput :: String -> Map String (Int, [String])
parseInput = Map.fromList . map (runParser parseLine) . lines

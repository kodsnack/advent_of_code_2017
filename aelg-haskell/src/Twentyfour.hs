module Twentyfour
  ( solve
  ) where

import           Data.List
import           Data.Tuple
import           Data.Maybe
import qualified Data.Map.Strict as M
import           Text.ParserCombinators.ReadP

parse :: [String] -> [(Int, Int)]
parse = map (fst . last . readP_to_S p)
  where
    p = do
      a <- many1 get
      char '/'
      b <- many1 get
      return (read a, read b)

newtype Tree = Node ((Int, Int), [Tree]) deriving Show

type ComponentSet = M.Map Int [Int]

cSetAdd cSet (a,b) = M.alter (f a) b (M.alter (f b) a cSet)
  where
    f a = maybe (Just [a]) (\xs -> Just (a : xs))

cSetFromList :: [(Int, Int)] -> ComponentSet
cSetFromList = go M.empty
  where
    go cSet [] = M.empty
    go cSet (x:xs) = cSetAdd (go cSet xs) x

cSetDelete cSet (a,b) = M.alter (f a) b (M.alter (f b) a cSet)
  where
    f a b = Just (delete a $ fromJust b)

cSetLookup cSet a = fromMaybe [] (M.lookup a cSet)

bridges :: ComponentSet -> [Tree]
bridges m = go m 0
  where
    go :: ComponentSet -> Int -> [Tree]
    go m a
      | null allFitting = []
      | otherwise = map f allFitting
      where
        allFitting = cSetLookup m a
        f :: Int -> Tree
        f c = Node ((a,c), go nM c)
          where
            nM = cSetDelete m (a,c)

sumP (a,b) = a+b

strength a = sum (map sumP a)

strongest a b = strength a `compare` strength b

maxDepth :: [Tree] -> (Int, Int) -- (strength, depth)
maxDepth [] = (0, 0)
maxDepth trees = maximum $ map go trees
  where
    go (Node ((a,b), trees)) = (a+b+s, d + 1)
      where (s, d) = maxDepth trees

maxStrength :: [Tree] -> (Int, Int) -- (strength, depth)
maxStrength [] = (0, 0)
maxStrength trees = maximumBy comp $ map go trees
  where
    (s1,d1) `comp` (s2,d2)
      | d1 /= d2 = d1 `compare` d2
      | otherwise = s1 `compare` s2
    go (Node ((a,b), trees)) = (a+b+s, d + 1)
      where (s, d) = maxStrength trees

nodes :: [Tree] -> Int
nodes [] = 1
nodes trees = sum $ map go trees
  where
    go (Node ((a,b), trees)) = nodes trees

solve1 = fst . maxDepth

solve2 = fst . maxStrength

solve :: [String] -> (String, String)
solve s = (show $ solve1 l, show $ solve2 l)
  where l = bridges . cSetFromList . parse $ s

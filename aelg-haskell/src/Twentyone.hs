module Twentyone
  ( solve
  ) where

import           Control.Arrow
import           Data.Foldable
import           Data.List
import           Data.List.Split
import qualified Data.Map.Strict as M
import           Data.Maybe
import           Data.Sequence   ((<|), (><))
import qualified Data.Sequence   as S

type Block = S.Seq (S.Seq Char)

parse s = map f l
  where
    l = map (map (splitOn "/") . words) s
    f l = (from, to)
      where
        from = head l
        to = l !! 2

toBlock s = S.fromList (map S.fromList s)

rotationAndFlips xs x
  | length xs == 8 = xs
  | otherwise = rotationAndFlips (f x ++ xs) (map reverse . transpose $ x)
  where
    f x = [transpose x, map reverse . transpose $ x]

toMap :: [([[String]], [String])] -> M.Map Block Block
toMap l = M.fromList (concatMap f l)
  where
    f (from:froms, to) = (toBlock from, toBlock to) : f (froms, to)
    f ([], to)         = []

blockMap :: (Block -> Block) -> Block -> Block
blockMap f l
  | even (length l) = fromBlocks 2 . fmap f . toBlocks 2 $ l
  | otherwise = fromBlocks 3 . fmap f . toBlocks 3 $ l
  where
    toBlocks = getRows
      where
        getRows s l
          | S.null l = S.empty
          | otherwise = getBlocks s (S.take s l) >< getRows s (S.drop s l)
        getBlocks s l
          | S.null $ asum l = S.empty
          | otherwise = fmap (S.take s) l <| getBlocks s (fmap (S.drop s) l)
    fromBlocks :: Int -> S.Seq Block -> Block
    fromBlocks s ll
      | S.null ll = S.empty
      | otherwise =
        foldl (S.zipWith (><)) (S.replicate (s + 1) S.empty) (S.take nBlocks ll) ><
        fromBlocks s (S.drop nBlocks ll)
      where
        nBlocks = length l `div` s

initial = toBlock [".#.", "..#", "###"]

draw ticks s = map toList $ toList $ iterate (blockMap f) initial !! ticks
  where
    l = map (first $ rotationAndFlips []) (parse s)
    m = toMap l
    f block = fromJust $ M.lookup block m

solver ticks = length . filter (== '#') . concat . draw ticks

solve1 :: [String] -> Int
solve1 = solver 5

solve2 :: [String] -> Int
solve2 = solver 18

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

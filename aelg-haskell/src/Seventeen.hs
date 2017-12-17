module Seventeen
  ( solve
  ) where

import qualified Data.Map.Strict as M
import           Data.Maybe
import qualified Data.Sequence   as S

insert' step cur l (x:xs) = insert' step newC newL xs
  where
    newC = ((cur + step) `rem` length l) + 1
    newL = S.insertAt newC x l
insert' step cur l [] = (l, cur)

solve1 :: [String] -> Int
solve1 [s] = fromJust $ S.lookup (c + 1) l
  where
    step = read s
    (l, c) = insert' step 0 (S.fromList [0]) [1 .. 2017]

afterZero step size = f 0 0 1
  where
    f cur res x
      | x > size = res
      | newC == 1 = f newC x (x + 1)
      | otherwise = f newC res (x + 1)
      where
        newC = ((cur + step) `rem` x) + 1

solve2 :: [String] -> Int
solve2 [s] = afterZero step 50000000
  where
    step = read s

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

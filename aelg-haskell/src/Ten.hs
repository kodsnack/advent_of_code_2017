module Ten
  ( solve
  ) where

import           Data.Char
import           KnotHash

solve1 :: [String] -> Int
solve1 [s] = head finalList * (finalList !! 1)
  where
    finalList = sparseHash l
    l = read ('[' : s ++ "]") :: [Int]

solve2 :: [String] -> String
solve2 [s] = toHex $ knotHash l
  where
    l = map ord s

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

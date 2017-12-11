module Ten
  ( solve
  ) where

import           Data.Bits
import           Data.Char
import           Data.List
import           Numeric

reverse' :: Int -> Int -> [Int] -> [Int]
reverse' pos len list =
  take pos (drop (length list) rDList) ++
  take (length list - pos) (drop pos rDList)
  where
    end = drop pos list
    dList = list ++ list
    rDList =
      take pos dList ++
      reverse (take len (drop pos dList)) ++ drop (pos + len) dList

sparseHash :: [Int] -> [Int]
sparseHash l = finalList
  where
    ((_, _, finalList), _) = mapAccumL f (0, 0, [0 .. 255]) l
    f (pos, skip, list) i =
      (((pos + i + skip) `rem` length list, skip + 1, newList), i :: Int)
      where
        newList = reverse' pos i list

denseHash :: [Int] -> [Int]
denseHash (x:xs) = foldl xor 0 (take 16 (x : xs)) : denseHash (drop 16 (x : xs))
denseHash [] = []

toHex :: [Int] -> String
toHex = concatMap (`showHex` "")

solve1 :: [String] -> Int
solve1 [s] = head finalList * (finalList !! 1)
  where
    finalList = sparseHash l
    l = read ('[' : s ++ "]") :: [Int]

solve2 :: [String] -> String
solve2 [s] = toHex $ denseHash $ sparseHash ll
  where
    l = map ord s ++ [17, 31, 73, 47, 23]
    ll = concat $ replicate 64 l

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

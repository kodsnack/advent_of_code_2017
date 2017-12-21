module KnotHash (knotHash, toHex, sparseHash) where

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
denseHash (x:xs) = foldl' xor 0 (take 16 (x : xs)) : denseHash (drop 16 (x : xs))
denseHash [] = []

toHex :: [Int] -> String
toHex = concatMap (`showHex` "")

knotHash :: [Int] -> [Int]
knotHash l = denseHash . sparseHash $ ll
  where ll = concat $ replicate 64 (l ++ [17, 31, 73, 47, 23])
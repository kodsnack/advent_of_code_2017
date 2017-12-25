module Thirteen
  ( solve
  ) where

import Data.List
import Data.Maybe

parse :: String -> (Int, Int)
parse s = (head l, l !! 1)
  where
    l = map read . words . filter (/= ':') $ s

lengths (depth, range) = (depth, range, range * 2 - 2)

severity (depth, range, loopLength)
  | depth `mod` loopLength == 0 = depth * range
  | otherwise = 0

notCaught delay (depth, _, loopLength)
  | (depth + delay) `mod` loopLength == 0 = False
  | otherwise = True

solve1 :: [String] -> Int
solve1 s = sum (map severity l)
  where
    l = map (lengths . parse) s

solve2 :: [String] -> Int
solve2 s = snd $ fromJust $ find fst $ map f [0 ..]
  where
    l = map (lengths . parse) s
    f delay = (all (notCaught delay) l, delay)

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

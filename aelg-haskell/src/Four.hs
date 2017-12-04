module Four
  ( solve
  ) where

import           Control.Arrow
import           Data.List

solve1 :: [String] -> Int
solve1 = map (words >>> sort >>> group >>> map length >>> maximum) >>> filter (==1) >>> length

solve2 :: [String] -> Int
solve2 = map (words >>> map sort >>> sort >>> group >>> map length >>> maximum) >>> filter (==1) >>> length

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

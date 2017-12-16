module Fifteen
  ( solve
  ) where

import           Data.Bits
import           Data.List
import           Data.Word

parse :: [String] -> (Int, Int)
parse [a, b] = (read . last . words $ a, read . last . words $ b)

solve1 :: [String] -> Int
solve1 s = length $ filter matches l
  where
    (a, b) = parse s
    update (a, b) _ =
      ( (a * 16807 `rem` 2147483647, b * 48271 `rem` 2147483647)
      , (a * 16807 `rem` 2147483647, b * 48271 `rem` 2147483647))
    (acc, l) = mapAccumL update (a, b) [1 .. 40000000]
    matches (a, b) = (a .&. 0xffff) == (b .&. 0xffff)

solve2 :: [String] -> Int
solve2 s =
  length $
  filter
    matches
    (zip
       (take 5000000 (filter (divisible 4) lA))
       (take 5000000 (filter (divisible 8) lB)))
  where
    (a, b) = parse s
    update factor a _ =
      (a * factor `rem` 2147483647, a * factor `rem` 2147483647)
    (accA, lA) = mapAccumL (update 16807) a [1 ..]
    (accB, lB) = mapAccumL (update 48271) b [1 ..]
    matches (a, b) = (a .&. 0xffff) == (b .&. 0xffff)
    divisible d x = (x `rem` d) == 0

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

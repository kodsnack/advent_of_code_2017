module Fifteen
  ( solve
  ) where

import           Data.Bits
import           Data.List
import           Data.Word

parse :: [String] -> (Int, Int)
parse [a, b] = (read . last . words $ a, read . last . words $ b)

wrap x = x `rem` 2147483647

solve1 :: [String] -> Int
solve1 s = length l
  where
    factors = parse s
    update ((a, b), l) _
      | matches p = (p, p:l)
      | otherwise = (p,l)
      where
        p = (wrap (a * 16807), wrap (b * 48271))
    (_, l) = foldl' update (factors,[]) [1 .. 40000000]
    matches (a, b) = (a .&. 0xffff) == (b .&. 0xffff)

solve2 :: [String] -> Int
solve2 s =
  length $
  filter
    matches $
    zip lA lB
  where
    (a, b) = parse s
    update factor divisibleBy len a
      | len == 0 = []
      | v `rem` divisibleBy == 0 = v : update factor divisibleBy (len-1) v
      | otherwise = update factor divisibleBy len v
      where
        v = wrap (a * factor)
    lA = update 16807 4 5000000 a
    lB = update 48271 8 5000000 b
    matches (a, b) = (a .&. 0xffff) == (b .&. 0xffff)

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

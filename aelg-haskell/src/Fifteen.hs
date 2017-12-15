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
solve1 s = length $ filter matches $ take 40000000 l
  where
    factors = parse s
    update (a, b) _ =
      let p = (wrap (a * 16807), wrap (b * 48271))
      in (p, p)
    (acc, l) = mapAccumL update factors [1 ..]
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
      let v = wrap (a * factor)
      in (v, v)
    (accA, lA) = mapAccumL (update 16807) a [1 ..]
    (accB, lB) = mapAccumL (update 48271) b [1 ..]
    matches (a, b) = (a .&. 0xffff) == (b .&. 0xffff)
    divisible d x = (x `rem` d) == 0

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

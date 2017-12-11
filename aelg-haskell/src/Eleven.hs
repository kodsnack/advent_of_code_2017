module Eleven
  ( solve
  ) where

import           Data.List

type Pos = (Int, Int, Int)

parse :: String -> [String]
parse s = words $ map toSpaceSeparated s
  where
    toSpaceSeparated ',' = ' '
    toSpaceSeparated c   = c

move :: Pos -> String -> Pos
move (x, y, z) "n"  = (x + 0, y + 1, z - 1)
move (x, y, z) "nw" = (x - 1, y + 1, z + 0)
move (x, y, z) "sw" = (x - 1, y + 0, z + 1)
move (x, y, z) "s"  = (x + 0, y - 1, z + 1)
move (x, y, z) "se" = (x + 1, y - 1, z + 0)
move (x, y, z) "ne" = (x + 1, y + 0, z - 1)

distance :: Pos -> Int
distance (x, y, z) = (abs x + abs y + abs z) `div` 2

solve1 :: [String] -> Int
solve1 [s] = distance $ foldl move (0, 0, 0) $ parse s

solve2 :: [String] -> Int
solve2 [s] = maximum distances
  where
    l = parse s
    (_, distances) = mapAccumL accumulate (0, 0, 0) l
    accumulate pos dir = (move pos dir, distance $ move pos dir)

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

module Eleven
  ( solve
  ) where

parse s = words $ map toSpaceSeparated s
  where
    toSpaceSeparated ',' = ' '
    toSpaceSeparated c   = c

move (x, y, z) "n"  = (x + 0, y + 1, z - 1)
move (x, y, z) "nw" = (x - 1, y + 1, z + 0)
move (x, y, z) "sw" = (x - 1, y + 0, z + 1)
move (x, y, z) "s"  = (x + 0, y - 1, z + 1)
move (x, y, z) "se" = (x + 1, y - 1, z + 0)
move (x, y, z) "ne" = (x + 1, y + 0, z - 1)

distance (x, y, z) = (abs x + abs y + abs z) `div` 2

solve1 :: [String] -> Int
solve1 [s] = distance $ foldl move (0, 0, 0) $ parse s

solve2 :: [String] -> Int
solve2 [s] =
  maximum $
  map ((distance . foldl move (0, 0, 0)) . flip take l) [0 .. (length l)]
  where
    l = parse s

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

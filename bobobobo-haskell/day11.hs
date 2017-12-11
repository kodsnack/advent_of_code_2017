module Main where

import Data.List.Split (splitOn)

distance :: (Int, Int) -> Int
distance (x, y) =
    max (abs x) $ max (abs y) (abs 0-x-y)

offset :: String -> (Int, Int)
offset dir =
    case dir of
        "n" -> (0, -1)
        "ne" -> (1, -1)
        "se" -> (1, 0)
        "s" -> (0, 1)
        "sw" -> (-1, 1)
        "nw" -> (-1,0)

solver :: String -> (Int, (Int, Int))
solver input =
    foldl (\(m, coord) dir -> let newcoord = move coord dir in (max (distance newcoord) m, newcoord)) (0,(0,0)) $ splitOn "," input
    where
        move (x, y) dir = let (dx, dy) = offset dir in (x+dx, y+dy)

solve1 :: String -> Int
solve1 =
    distance.snd.solver

solve2 :: String -> Int
solve2 =
    fst.solver

main :: IO ()
main = do
    input <- getLine
    print $ solve1 input
    print $ solve2 input

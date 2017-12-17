module D17 where

import Data.List (foldl')

parseInput :: String -> Int
parseInput input = read input


insertions :: Int -> Int -> Int -> [Int] -> [Int]
insertions lim jmp v xs
    | v == lim = xs
    | otherwise = insertions lim jmp (v+1) (take (v+1) (v : (drop jmp (cycle xs) )))

solve1 :: String -> Int
solve1 input = head $ tail $ insertions 2018 (inp+1) 1 [0]
    where inp = parseInput input


positions :: Int -> Int -> Int -> Int -> [(Int,Int)]
positions p v lim jmp
    | v <= lim  = (p,v-1) : (positions p' (v+1) lim jmp)
    | otherwise = []
    where
        p' = ((p + jmp) `mod` v) + 1

solve2 :: String -> Int
solve2 input = foldl' go 0 (positions 0 1 50000000 inp)
    where
        inp = parseInput input
        go prevV (p,v)
            | p == 1 = v
            | otherwise = prevV

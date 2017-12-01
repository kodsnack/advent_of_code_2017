module Main where

import Data.Char

solver :: Int -> [Int] -> Int
solver offset list =
    foldl (\s (i, v) -> if v == (list!!next i) then s + v else s) 0 $ zip [0..] list
    where
        l = length list
        next i = mod (i+offset) l

solve1 :: [Int] -> Int
solve1 = solver 1

solve2 :: [Int] -> Int
solve2 l = solver (quot (length l) 2) l

main :: IO ()
main = do
    str <- getLine
    let
        list = map digitToInt str
    print $ solve1 list
    print $ solve2 list
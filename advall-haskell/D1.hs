module D1 where

import Data.Char (digitToInt)

parseInput :: String -> [Int]
parseInput input = map digitToInt $ filter (/= '\n') input


solve1 :: String -> Int
solve1 input = solve1' 0 $ (parseInput input) ++ [head (parseInput input)]

solve1' :: Int -> [Int] -> Int
solve1' i [x] = i
solve1' i (x:y:xs)
    | x==y = solve1' (i+x) (y:xs)
    | otherwise = solve1' i (y:xs)


solve2 :: String -> Int
solve2 input = solve2' 0 (parseInput input) $ sndHalf ++ fstHalf
    where   sndHalf = drop half (parseInput input)
            fstHalf = take half (parseInput input)
            half = (length (parseInput input)) `div` 2

solve2' :: Int -> [Int] -> [Int] -> Int
solve2' i [] _ = i
solve2' i (x:xs) (y:ys)
    | x == y = solve2' (i+x) xs ys
    | otherwise = solve2' i xs ys

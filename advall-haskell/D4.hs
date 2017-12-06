 module D4 where

import Data.List (sort, nub)

parseInput :: String -> [[String]]
parseInput input = map words $ lines input


solve1 :: String -> Int
solve1 input = length $ filter isValid1 $ parseInput input

isValid1 :: [String] -> Bool
isValid1 s = s == nub s


solve2 :: String -> Int
solve2 input = length $ filter isValid2 $ parseInput input

isValid2 :: [String] -> Bool
isValid2 s = isValid1 $ map sort s

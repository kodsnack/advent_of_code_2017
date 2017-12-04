module Main where

import Data.Maybe (mapMaybe)
import Data.List (uncons, tails)
import Control.Monad

solve1 :: [[Int]] -> Int
solve1 input = sum $ map ((\(minv,maxv) -> maxv-minv) . minmax) input
    where 
        minmax =
            foldl minmax' (maxBound, minBound)
            where
                minmax' (minv, maxv) v =
                    (min v minv, max v maxv)

solve2 :: [[Int]] -> Int
solve2 input =
    sum $ map solverow input
    where 
        solverow [] = 0
        solverow [_] = 0
        solverow (v1:xs) = v + solverow xs
                            where  
                                v = sum $ map d xs
                                d v2 = if mod (max v1 v2) (min v1 v2) == 0 then div (max v1 v2) (min v1 v2) else 0

solve1' :: [[Int]] -> Int
solve1' input = sum $ map abs $ zipWith (-) (map maximum input) (map minimum input)
    
solve2' :: [[Int]] -> Int
solve2' sheet = sum $ sheet >>= ((mapMaybe uncons . tails) >=> (\(v1, r) -> r >>= (\v2 -> [x | x <- [div (max v1 v2) (min v1 v2)], mod (max v1 v2) (min v1 v2) == 0])))
                                
main :: IO ()
main = 
        do
        str <- getContents
        let
            input = map (map read . words) $ lines str
        print $ solve1 input
        print $ solve2 input
        print $ solve1' input
        print $ solve2' input
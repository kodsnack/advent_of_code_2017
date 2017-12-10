module D10 where

import Data.List (foldl')
import Data.List.Split (splitOn, chunksOf)
import Data.Char (ord)
import Data.Bits (xor)
import Numeric (showHex)

parseInput1 :: String -> [Int]
parseInput1 input = map read $ splitOn "," $ input

steps :: [Int] -> [Int] -> [Int] -> Int -> [Int]
steps vs1 vs2 []     _    = vs1 ++ vs2
steps vs1 vs2 (l:ls) skip = steps vs1' vs2' ls (skip+1)
    where
        (vs1',vs2') = shiftCurrentPos (skip + l) vs1'' vs2''
        vs1''       = resOfTwist1 ++ (drop (length resOfTwist1) vs1)
        vs2''       = resOfTwist2 ++ (drop (length resOfTwist2) vs2)
        resOfTwist1 = drop (length vs2) resOfTwist
        resOfTwist2 = take (length vs2) resOfTwist
        resOfTwist  = reverse $ take l $ vs2 ++ vs1

shiftCurrentPos :: Int -> [Int] -> [Int] -> ([Int],[Int])
shiftCurrentPos n vs1 vs2
    | m <= length vs2 = (vs1 ++ take m vs2, drop m vs2)
    | otherwise       = (take o vs1, drop o vs1 ++ vs2)
    where 
        o = m - length vs2
        m = n `mod` (length vs1 + length vs2)

solve1 :: String -> Int
solve1 input = product $ take 2 $ steps [] [0..255] ls 0
    where ls = parseInput1 input


parseInput2 :: String -> [Int]
parseInput2 input = map ord input ++ [17, 31, 73, 47, 23]

stepsNRounds :: Int -> [Int] -> [Int] -> Int -> [Int]
stepsNRounds n vs ls skip = steps [] vs lsN 0
    where lsN = take (n * (length ls)) $ cycle ls

xorList :: [Int] -> Int
xorList xs = foldl' xor 0 xs

toHexStr :: Int -> String
toHexStr x = case length s of 
    1 -> '0' : s
    2 -> s
    where s = showHex x ""

solve2 :: String -> String
solve2 input = denseHashHex
    where
        denseHashHex = concatMap toHexStr denseHash
        denseHash    = map xorList $ chunksOf 16 sparseHash
        sparseHash   = stepsNRounds n [0..255] ls 0
        ls           = parseInput2 input
        n            = 64

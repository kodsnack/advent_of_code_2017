module D15 where

import Data.List (foldl', scanl')
import Data.Bits ((.&.))
import Data.Word

parseInput :: String -> (Integer,Integer)
parseInput input = (\[a,b] -> (a,b)) $ map (read . last . words) $ lines input


gen :: Integer -> Integer -> [Integer]
gen prevVal factor = compVal : gen (nextVal) factor
    where 
        compVal = prevVal .&. 0xffff
        nextVal = (prevVal * factor) `mod` 2147483647

solve1 :: String -> Int
solve1 input = length $ filter (\b -> b) $ take 40000000 comps
    where 
        comps         = zipWith (==) genA genB
        genA          = gen aSeed 16807
        genB          = gen bSeed 48271
        (aSeed,bSeed) = parseInput input


solve2 :: String -> Int
solve2 input = length $ filter (\b -> b) $ take 5000000 comps
    where 
        comps         = zipWith (==) genA genB
        genA          = filter (\x -> (x `mod` 4) == 0) $ gen aSeed 16807
        genB          = filter (\x -> (x `mod` 8) == 0) $ gen bSeed 48271
        (aSeed,bSeed) = parseInput input

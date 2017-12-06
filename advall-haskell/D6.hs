module D6 where

import Data.Map (Map)
import qualified Data.Map as Map
import Data.List (sort, sortBy, maximumBy)

parseInput :: String -> [(Integer,Integer)]
parseInput input = zip xs [1,2..]
    where xs = map read (words input)


solve1 :: String -> Integer
solve1 input = snd $ findCycle 0 (parseInput input) Map.empty

findCycle :: Integer -> [(Integer,Integer)] 
                -> Map [(Integer,Integer)] Integer -> (Integer, Integer)
findCycle n xs mem = case Map.lookup (sort xs) mem of
    Just lastSeenN  -> (lastSeenN, n)
    Nothing -> findCycle (n+1) (redistribute xs) (Map.insert (sort xs) n mem)

redistribute :: [(Integer,Integer)] -> [(Integer,Integer)]
redistribute xs = distribute xMax $ fstHalf ++ sndHalf ++ [(0,pMax)]
    where   fstHalf       = tail $ dropWhile (/= m) xs
            sndHalf       = takeWhile (/= m) xs
            m@(xMax,pMax) = maximumBy (highValLowI) xs
            highValLowI (v1,i1) (v2,i2)
                | v1 /= v2 = compare v1 v2
                | otherwise = compare i2 i1

distribute :: Integer -> [(Integer,Integer)] -> [(Integer,Integer)]
distribute 0 xs         = xs
distribute n ((x,p):xs) = distribute (n-1) $ xs ++ [(x+1,p)]


solve2 :: String -> Integer
solve2 input = n' - n
    where (n,n') = findCycle 0 (parseInput input) Map.empty
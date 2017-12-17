module D14 where

import D10 (solve2)
import Data.Char (digitToInt, intToDigit)
import Numeric (showIntAtBase)
import Data.Set (Set)
import qualified Data.Set as Set

type Grid = Set (Int,Int)

parseInput :: String -> [String]
parseInput input = map (\i -> input ++ ('-':(show i))) [0..127] 


binaryKnotHash :: String -> String
binaryKnotHash s = concatMap (toBinary . digitToInt) (D10.solve2 s)
    where 
        toBinary i = addLeadingZeros $ showIntAtBase 2 intToDigit i ""
        addLeadingZeros s = (take (4 - length s) (map intToDigit [0,0..])) ++ s

solve1 :: String -> Int
solve1 input = length $ filter (== '1') $ concatMap binaryKnotHash $ parseInput input


seedToGrid :: String -> Grid
seedToGrid s = hashesToGrid $ concatMap binaryKnotHash $ parseInput s
  where 
    hashesToGrid ss = Set.fromList $ map fst $ filter snd $ zip allPos  (map (== '1') ss)
    allPos = zip (cycle [0..127]) (concatMap (replicate 128) [0..127])

removeRegionIncluding :: (Int,Int) -> Grid -> Grid
removeRegionIncluding (x,y) g = g5
    where
        g5 = continueIfIn (x  ,y+1) g4
        g4 = continueIfIn (x  ,y-1) g3
        g3 = continueIfIn (x+1,y  ) g2
        g2 = continueIfIn (x-1,y  ) g1
        g1 = Set.delete (x,y) g
        continueIfIn p@(a,b) gX
            | a < 0 || a > 127 || b < 0 || b > 127 = gX
            | Set.member p gX = removeRegionIncluding p gX
            | otherwise = gX

countRegions :: Int -> Grid -> Int
countRegions i g
    | g == Set.empty = i
    | otherwise      = countRegions (i+1) g'
    where g' = removeRegionIncluding (last (Set.elems g)) g

solve2 :: String -> Int
solve2 input = countRegions 0 $ seedToGrid input

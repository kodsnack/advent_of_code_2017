module D12 where

import Data.Set (Set)
import qualified Data.Set as Set

parseInput :: String -> [[String]]
parseInput input = map (words . removeCommas) $ lines input

removeCommas :: String -> String
removeCommas s = [c | c <- s, c /= ',']


mkGroup :: [[String]] -> Set String -> (Set String,[[String]])
mkGroup ls g
    | Set.size g == Set.size g' = (g,ls')
    | otherwise                 = mkGroup ls' g'
    where (g',ls') = mkGroup' ls g []

mkGroup' :: [[String]] -> Set String -> [[String]] -> (Set String,[[String]])
mkGroup' [] g zs = (g, zs)
mkGroup' (z@(x:"<->":xs):ls) g zs
    | Set.size (thisRow `Set.intersection` g) > 0 = mkGroup' ls (g `Set.union` thisRow) zs
    | otherwise                                   = mkGroup' ls g (z:zs)
    where thisRow = Set.fromList (x:xs)

solve1 :: String -> Int
solve1 input = Set.size $ fst $ mkGroup (parseInput input) $ Set.fromList ["0"]


mkGroups :: [[String]] -> Set String -> [Set String]
mkGroups [] g = []
mkGroups ls g = g' : mkGroups ls' (Set.fromList [(head (head ls'))])
    where (g',ls') = mkGroup ls g

solve2 :: String -> Int
solve2 input = length $ mkGroups (parseInput input) $ Set.fromList ["0"]

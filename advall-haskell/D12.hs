module D12 where

import Data.Set (Set)
import qualified Data.Set as Set

parseInput :: String -> [[Int]]
parseInput input = map parseLine $ lines $ input
    where parseLine = (  (\(w:_:ws) -> (map read (w:ws))) 
                       . words 
                       . (\s -> [c | c <- s, c /= ','])   )


mkGroup :: [[Int]] -> Set Int -> (Set Int,[[Int]])
mkGroup ls g
    | Set.size g == Set.size g' = (g,ls')
    | otherwise                 = mkGroup ls' g'
    where (g',ls') = mkGroup' ls g []

mkGroup' :: [[Int]] -> Set Int -> [[Int]] -> (Set Int,[[Int]])
mkGroup' [] g zs = (g, zs)
mkGroup' (z@(x:xs):ls) g zs
    | thisRowOverlapsWithG = mkGroup' ls (g `Set.union` thisRow) zs
    | otherwise            = mkGroup' ls g (z:zs)
    where 
        thisRowOverlapsWithG = Set.size (thisRow `Set.intersection` g) > 0
        thisRow = Set.fromList z

solve1 :: String -> Int
solve1 input = Set.size $ fst $ mkGroup (parseInput input) $ Set.singleton 0


mkGroups :: Int -> [[Int]] -> Set Int -> Int
mkGroups i [] g = i
mkGroups i ls g = mkGroups (i+1) ls' (Set.fromList [(head (head ls'))])
    where (g',ls') = mkGroup ls g

solve2 :: String -> Int
solve2 input = mkGroups 0 (parseInput input) $ Set.singleton 0

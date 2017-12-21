module D21 where

import Data.List (transpose)
import Data.List.Split (chunksOf, splitOn)
import Data.Map (Map, (!))
import qualified Data.Map as Map

type Grid = [[Bool]]
type Rule = (Grid,Grid)
type Rules = Map Grid Grid

startGrid :: Grid
startGrid = map (map (== '#')) [".#.","..#","###"]


parseInput :: String -> Rules
parseInput input = Map.fromList $ concatMap parseLine $ lines input

parseLine :: String -> [Rule]
parseLine s = zip (rotationsAndFlips from) (repeat to)
    where
        from            = map (map (== '#')) strFrom
        to              = map (map (== '#')) strTo
        [strFrom,strTo] = map (splitOn "/") $ splitOn " => " s

rotationsAndFlips :: Grid -> [Grid]
rotationsAndFlips g = rotations g ++ rotations (flipp g)
    where 
        rotations gx = [gx, rotate gx, rotateTwice gx, rotateTrice gx]
        rotateTwice  = rotate . rotate
        rotateTrice  = rotate . rotateTwice
        rotate       = flipp . transpose
        flipp        = map reverse


nSteps :: Int -> Grid -> Rules -> Grid
nSteps 0 g _  = g
nSteps i g rs = nSteps (i-1) (next g) rs
    where
        next      = putTogether . map transform . breakUp 
        transform = (rs !) 

breakUp :: Grid -> [Grid]
breakUp g 
    | length g `mod` 2 == 0 = breakUpToNxN 2 g
    | otherwise             = breakUpToNxN 3 g

breakUpToNxN :: Int -> Grid -> [Grid]
breakUpToNxN _ [] = []
breakUpToNxN n g  = fstNRowsToNxNs ++ breakUpToNxN n restOfRows
    where
        fstNRowsToNxNs                 = merge $ map (chunksOf n) $ fstNRows
        fstNRows                       = take n g
        restOfRows                     = drop n g
        merge ([]:_)                   = []
        merge [(x:xs), (y:ys)]         = [x,y]   : merge [xs, ys]
        merge [(x:xs), (y:ys), (z:zs)] = [x,y,z] : merge [xs, ys, zs]

putTogether :: [Grid] -> Grid
putTogether gs = putTogether' partSize gs
    where partSize = round $ sqrt $ fromIntegral $ length gs

putTogether' :: Int -> [Grid] -> Grid
putTogether' partSize [] = []
putTogether' partSize gs = (merge fstRowOfGrids) ++ putTogether' partSize restOfGrids
    where
        fstRowOfGrids    = take partSize gs
        restOfGrids      = drop partSize gs
        merge ([]:_)     = []
        merge rowOfGrids = concatMap head rowOfGrids : merge (map tail rowOfGrids)


countLit :: Grid -> Int
countLit g = length $ filter (\x -> x) $ concat g


solve1 :: String -> Int
solve1 input = countLit $ nSteps 5 startGrid rules
    where rules = parseInput input


solve2 :: String -> Int
solve2 input = countLit $ nSteps 18 startGrid rules
    where rules = parseInput input

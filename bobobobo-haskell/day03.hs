module Main where

import qualified Data.Map as Map

ringSize :: Int -> Int
ringSize ring = 
    max (ring * 8) 1

highestNumberInRing :: Int -> Int
highestNumberInRing ring = sideLength ring * sideLength ring

findRing :: Int -> Int
findRing n =
    div (root-1) 2
    where
        nearestRoot = ceiling (sqrt (fromIntegral n))
        evenRoot = mod nearestRoot 2 == 0
        root = if evenRoot then nearestRoot+1 else nearestRoot
    
sideLength :: Int -> Int
sideLength ring =
   ring * 2+1

bottomRightCoord :: Int -> (Int, Int)
bottomRightCoord ring =
    (ring, ring)

distance :: (Int, Int) -> Int
distance (x, y) =
    abs x + abs y

coord :: Int -> (Int, Int)
coord n | steps >= 0 && steps <= side = (ring-steps, ring)
        | steps > side && steps <= side*2 = (ring-side, ring-(steps-side))
        | steps > side*2 && steps <= side*3 = (-(ring-(steps-(side*2))), ring-side)
        | otherwise = (ring, -(ring-(steps-(side*3))))
    where
        ring = findRing n
        steps = highestNumberInRing ring - n
        side = sideLength ring-1

solve1 :: Int -> Int
solve1 = distance . coord 

neighbours :: (Int, Int) -> [(Int, Int)]
neighbours (x, y) = [
        (x-1, y),
        (x-1, y-1),
        (x-1, y+1),
        (x+1, y),
        (x+1, y-1),
        (x+1, y+1),
        (x, y-1),
        (x, y+1)
    ]

sumNeighbours :: (Int, Int) -> Map.Map (Int, Int) Int -> Int
sumNeighbours c storedData =
     sum $ map (\c -> Map.findWithDefault 0 c storedData) $ neighbours c

sumUntilLarger :: Int -> Int -> Int
sumUntilLarger n m =
    if nsum > m then nsum else sumUntilLarger (n+1) m
    where
        nsum = sum' 1 (Map.singleton (0,0) 1)
        sum' v d =
            if v==n then
                csum
            else
                sum' (v+1) (Map.insert c csum d)
            where
                csum = if v == 1 then 1 else sumNeighbours c d
                c = coord v

solve2 :: Int -> Int
solve2 =
    sumUntilLarger 1

main :: IO ()
main = do
    line <- getLine
    let
        input = read line
    print $ solve1 input
    print $ solve2 input
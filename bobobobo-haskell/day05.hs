module Main where

import Control.Monad.ST
import qualified Data.Vector as V
import qualified Data.Vector.Mutable as M

solver f m = runST $ do
        maze <- V.thaw m
        step 0 0 maze
        where
            step steps index maze
                | index >= M.length maze = return steps
                | otherwise = do
                    offset <- M.read maze index
                    M.write maze index $ f offset
                    step (steps+1) (index+offset) maze

solver' f m = 
    step 0 0 m
    where
        mazeLength = V.length m
        step steps index maze 
            | index >= mazeLength = steps
            | otherwise = step (steps+1) (index+nextStep) (maze V.// [(index, f nextStep)])
            where
                nextStep = maze V.! index
                    
solve1 :: V.Vector Int -> Int
solve1 = solver (1+)

solve2 :: V.Vector Int -> Int
solve2 = solver (\x -> if x >= 3 then x-1 else x+1)
        
parseInput :: String -> [Int]
parseInput line =
    map read $ lines line

main :: IO ()
main = do
    line <- getContents
    let
        input = V.fromList $ parseInput line

    print $ solve1 input
    print $ solve2 input
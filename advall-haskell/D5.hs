module D5 where

import Data.IntMap (IntMap)
import qualified Data.IntMap as Map

parseInput :: String -> IntMap Int
parseInput input = Map.fromList $ zip [0,1..] $ map read $ lines input


solve1 :: String -> Int
solve1 input = jump 0 0 (+1) $ parseInput input

jump :: Int -> Int -> (Int -> Int) -> IntMap Int -> Int
jump n pc adjustFun instrs = case Map.lookup pc instrs of
    Nothing     -> n
    Just offset -> jump (n + 1) (pc + offset) adjustFun instrs'
    where instrs' = Map.adjust adjustFun pc instrs


solve2 :: String -> Int
solve2 input = jump 0 0 (incDec) $ parseInput input

incDec :: Int -> Int
incDec x
    | x < 3     = x + 1
    | otherwise = x - 1

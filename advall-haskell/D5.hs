module D5 where

import Data.Map (Map)
import qualified Data.Map as Map

parseInput :: String -> Map Integer Integer
parseInput input = Map.fromList $ zip [0,1..] $ map read $ lines input


solve1 :: String -> Integer
solve1 input = jump 0 0 (+1) $ parseInput input

jump :: Integer -> Integer -> (Integer -> Integer) -> Map Integer Integer -> Integer
jump n pc adjustFun instrs = case Map.lookup pc instrs of
    Nothing     -> n
    Just offset -> jump (n + 1) (pc + offset) adjustFun instrs'
    where instrs' = Map.adjust adjustFun pc instrs


solve2 :: String -> Integer
solve2 input = jump 0 0 (incDec) $ parseInput input

incDec :: Integer -> Integer
incDec x
    | x < 3     = x + 1
    | otherwise = x - 1

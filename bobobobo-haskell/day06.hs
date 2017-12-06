module Main where

import qualified Data.Vector.Unboxed as V
import Data.Map.Strict as Map

distributeHighest :: V.Vector Int -> V.Vector Int
distributeHighest input =
    distribute startIndex (input V.! startIndex) (input V.// [(startIndex,0)])
    where
        startIndex = V.maxIndex input
        distribute index value vector
            | value == 1 = vector V.// [(nextIndex, nextValue)]
            | otherwise = distribute nextIndex (value-1) (vector V.// [(nextIndex, nextValue)])
            where
                nextIndex = mod (index+1) (V.length input)
                nextValue = (vector V.! nextIndex) + 1

solver :: V.Vector Int -> (Int, Int)
solver input =
    step 0 (Map.singleton input 0) input
    where
        step steps seen input =
            case Map.lookup next seen of
                Just loopStart -> (steps+1, steps - loopStart)
                Nothing -> step (steps+1) (Map.insert next steps seen) next
            where
                next = distributeHighest input

solve1 :: [Int] -> Int
solve1 = fst.solver.V.fromList

solve2 :: [Int] -> Int
solve2 = snd.solver.V.fromList

parseInput :: String -> [Int]
parseInput line =
    read <$> words line

main :: IO ()
main = do
    line <- getContents
    let
        input = parseInput line
    print $ solve1 input
    print $ solve2 input
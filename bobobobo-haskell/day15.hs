module Main where

import Data.Bits

factorA = 16807
factorB = 48271

divisor = 2147483647

generator :: Int -> Int -> Int -> Int
generator factor multipliesOf start
    | mod result multipliesOf == 0 = result
    | otherwise = generator factor multipliesOf result
    where
        result = rem (start * factor) divisor

solver :: (Int -> Int) -> (Int -> Int) -> Int -> Int -> Int -> Int
solver generatorA generatorB loops startA startB =
    solve1' startA startB 0 0
    where
        solve1' :: Int -> Int -> Int -> Int -> Int
        solve1' startA startB count matches
            | count > loops = matches
            | otherwise = solve1' v1 v2 (count+1) $ if (v1 .&. 0xffff) ==  (v2 .&. 0xffff) then matches+1 else matches
            where
                v1 = generatorA startA
                v2 = generatorB startB
                
solve1 :: Int -> Int -> Int
solve1 = solver (generator factorA 1) (generator factorB 1) 40000000

solve2 :: Int -> Int -> Int
solve2 = solver (generator factorA 4) (generator factorB 8) 5000000
   
startA = 516
startB = 190

main :: IO ()
main = do
    print $ solve1 startA startB    
    print $ solve2 startA startB

import System.Environment   
import Data.List 

import D1 (solve1, solve2)
import D2 (solve1, solve2)
import D3 (solve1, solve2)
import D4 (solve1, solve2)
import D5 (solve1, solve2)
import D6 (solve1, solve2)
import D7 (solve1, solve2)
import D8 (solve1, solve2)
import D9 (solve1, solve2)
import D10 (solve1, solve2)
import D11 (solve1, solve2)
import D12 (solve1, solve2)
import D13 (solve1, solve2)
import D14 (solve1, solve2)
import D15 (solve1, solve2)
import D16 (solve1, solve2)
import D17 (solve1, solve2)
import D18 (solve1, solve2)
import D19 (solve1, solve2)
import D20 (solve1, solve2)
import D21 (solve1, solve2)
import D22 (solve1, solve2)
import D23 (solve1, solve2)
import D24 (solve1, solve2)
import D25 (solve1, solve2)


solveDay x = case x of
    1  -> solveDay' x D1.solve1 D1.solve2
    2  -> solveDay' x D2.solve1 D2.solve2
    3  -> solveDay' x D3.solve1 D3.solve2
    4  -> solveDay' x D4.solve1 D4.solve2
    5  -> solveDay' x D5.solve1 D5.solve2
    6  -> solveDay' x D6.solve1 D6.solve2
    7  -> solveDay' x D7.solve1 D7.solve2
    8  -> solveDay' x D8.solve1 D8.solve2
    9  -> solveDay' x D9.solve1 D9.solve2
    10 -> solveDay' x D10.solve1 D10.solve2
    11 -> solveDay' x D11.solve1 D11.solve2
    12 -> solveDay' x D12.solve1 D12.solve2
    13 -> solveDay' x D13.solve1 D13.solve2
    14 -> solveDay' x D14.solve1 D14.solve2
    15 -> solveDay' x D15.solve1 D15.solve2
    16 -> solveDay' x D16.solve1 D16.solve2
    17 -> solveDay' x D17.solve1 D17.solve2
    18 -> solveDay' x D18.solve1 D18.solve2
    19 -> solveDay' x D19.solve1 D19.solve2
    20 -> solveDay' x D20.solve1 D20.solve2
    21 -> solveDay' x D21.solve1 D21.solve2
    22 -> solveDay' x D22.solve1 D22.solve2
    23 -> solveDay' x D23.solve1 D23.solve2
    24 -> solveDay' x D24.solve1 D24.solve2
    25 -> solveDay' x D25.solve1 D25.solve2

solveDay' :: (Show a, Show b) => Int -> (String -> a) -> (String -> b) -> IO ()
solveDay' x s1 s2 = do
    let inputFileName = "D" ++ show x ++"_input.txt"
    input <- readFile inputFileName
    let answer1 = s1 input
    putStrLn $ "Day " ++ show x ++ ", Part one: " ++ (show answer1)
    let answer2 = s2 input
    putStrLn $ "Day " ++ show x ++ ", Part two: " ++ (show answer2)

solveAll = mapM_ solveDay [1..25]
  
main = do  
    args <- getArgs  
    case args of
        [] -> solveAll
        _  -> do
            let days = map read args
            mapM_ solveDay days

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

solveDayX :: (Show a, Show b) => Int -> (String -> a) -> (String -> b) -> IO ()
solveDayX x s1 s2 = do
    let inputFileName = "D" ++ show x ++"_input.txt"
    input <- readFile inputFileName
    let answer1 = s1 input
    putStrLn $ "Day " ++ show x ++ ", Part one: " ++ (show answer1)
    let answer2 = s2 input
    putStrLn $ "Day " ++ show x ++ ", Part two: " ++ (show answer2)

main = do
    solveDayX 1 D1.solve1 D1.solve2
    solveDayX 2 D2.solve1 D2.solve2
    solveDayX 3 D3.solve1 D3.solve2
    solveDayX 4 D4.solve1 D4.solve2
    solveDayX 5 D5.solve1 D5.solve2
    solveDayX 6 D6.solve1 D6.solve2
    solveDayX 7 D7.solve1 D7.solve2
    solveDayX 8 D8.solve1 D8.solve2
    solveDayX 9 D9.solve1 D9.solve2
    solveDayX 10 D10.solve1 D10.solve2
    solveDayX 11 D11.solve1 D11.solve2
    solveDayX 12 D12.solve1 D12.solve2
    solveDayX 13 D13.solve1 D13.solve2
    solveDayX 14 D14.solve1 D14.solve2
    solveDayX 15 D15.solve1 D15.solve2
    solveDayX 16 D16.solve1 D16.solve2
    solveDayX 17 D17.solve1 D17.solve2
    solveDayX 18 D18.solve1 D18.solve2
    solveDayX 19 D19.solve1 D19.solve2
    solveDayX 20 D20.solve1 D20.solve2
    solveDayX 21 D21.solve1 D21.solve2
    solveDayX 22 D22.solve1 D22.solve2
    solveDayX 23 D23.solve1 D23.solve2
    solveDayX 24 D24.solve1 D24.solve2
    solveDayX 25 D25.solve1 D25.solve2

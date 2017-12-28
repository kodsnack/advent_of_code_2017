import System.Environment
import System.TimeIt 
import Data.List
import Data.Map (Map)
import qualified Data.Map as Map
import Data.List.Split (splitOn)

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


solveDay measureTime x = case x of
    1  -> solveDay' x measureTime D1.solve1 D1.solve2
    2  -> solveDay' x measureTime D2.solve1 D2.solve2
    3  -> solveDay' x measureTime D3.solve1 D3.solve2
    4  -> solveDay' x measureTime D4.solve1 D4.solve2
    5  -> solveDay' x measureTime D5.solve1 D5.solve2
    6  -> solveDay' x measureTime D6.solve1 D6.solve2
    7  -> solveDay' x measureTime D7.solve1 D7.solve2
    8  -> solveDay' x measureTime D8.solve1 D8.solve2
    9  -> solveDay' x measureTime D9.solve1 D9.solve2
    10 -> solveDay' x measureTime D10.solve1 D10.solve2
    11 -> solveDay' x measureTime D11.solve1 D11.solve2
    12 -> solveDay' x measureTime D12.solve1 D12.solve2
    13 -> solveDay' x measureTime D13.solve1 D13.solve2
    14 -> solveDay' x measureTime D14.solve1 D14.solve2
    15 -> solveDay' x measureTime D15.solve1 D15.solve2
    16 -> solveDay' x measureTime D16.solve1 D16.solve2
    17 -> solveDay' x measureTime D17.solve1 D17.solve2
    18 -> solveDay' x measureTime D18.solve1 D18.solve2
    19 -> solveDay' x measureTime D19.solve1 D19.solve2
    20 -> solveDay' x measureTime D20.solve1 D20.solve2
    21 -> solveDay' x measureTime D21.solve1 D21.solve2
    22 -> solveDay' x measureTime D22.solve1 D22.solve2
    23 -> solveDay' x measureTime D23.solve1 D23.solve2
    24 -> solveDay' x measureTime D24.solve1 D24.solve2
    25 -> solveDay' x measureTime D25.solve1 D25.solve2

solveDay' :: (Show a, Show b) => Int -> Bool -> (String -> a) -> (String -> b) 
                -> IO (Int,String,String)
solveDay' x measureTime s1 s2 = do
    let inputFileName = "D" ++ show x ++"_input.txt"
    let maybeTimeIt   = if measureTime then timeIt else id
    input <- readFile inputFileName 
    res1  <- maybeTimeIt $ solve s1 input "one"
    res2  <- maybeTimeIt $ solve s2 input "two"
    return (x, res1, res2)
    where
        solve f input part = do
            let res = show $ f input
            putStrLn $ "Day " ++ show x ++ ", Part " ++ part ++ ": " ++ res
            return answer


parseArgs :: [String] -> ([Int],[String])
parseArgs args = (days, flags)
    where
        days  = map read $ drop (length flags) sortedArgs
        flags = takeWhile ((== '-') . head) sortedArgs
        sortedArgs = sort args


parseExpectedRes :: String -> ((Int, Int), String)
parseExpectedRes = 
    (\[dp,r] -> (readMeta dp , r)) . splitOn ": "
    where
        readMeta dp = (\[d,p] -> (read (tail d), read (tail p)) ) $ splitOn "," dp


data CheckRes = Ok | Bad | NotChecked
    deriving Eq

check :: Map (Int,Int) String -> (Int, String, String) -> [(String,CheckRes)]
check expected (d, res1, res2) = 
    [(toMsg d 1, checkPart 1 res1), (toMsg d 2, checkPart 2 res2)]
    where
        toMsg day part = "day " ++ show day ++ ", part " ++ show part
        checkPart part res = case Map.lookup (d,part) expected of
            Just eRes -> if res == eRes then Ok else Bad
            Nothing   -> NotChecked


main = do  
    args <- getArgs
    let (days,flags) = parseArgs args
    let measureTime  = "-t" `elem` flags
    let checkResults = "-c" `elem` flags
    solutions <- case days of
                    [] -> mapM (solveDay measureTime) [1..25]
                    _  -> mapM (solveDay measureTime) days
    if not checkResults then return ()
    else do
        expectedRes' <- readFile "correctOutput.txt"
        let expectedRes = Map.fromList $ map (parseExpectedRes) $ lines expectedRes'
        let checked     = concatMap (check expectedRes) solutions
        let bad         = filter ((== Bad) . snd) checked
        let good        = filter ((== Ok) . snd) checked
        let notChecked  = filter ((== NotChecked) . snd) checked
        if bad == [] then 
            putStrLn "All checked solutions are correct!"
        else do
            putStrLn "The solutions to the following are WRONG:"
            mapM_ (putStrLn . fst) bad
            putStrLn "The solutions to the following are GOOD:"
            mapM_ (putStrLn . fst) good
        if notChecked == [] then
            putStrLn "All solutions that were run were checked."
        else do 
            putStrLn "The solutions to the following could not be checked:"
            mapM_ (putStrLn . fst) notChecked

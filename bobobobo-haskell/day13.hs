module Main where
    
import Data.List.Split

parseInput :: String -> [(Int, Int)]
parseInput line =
        parse <$> lines line

parse :: String -> (Int, Int)
parse line =
    (read $ head s, read (s!!1))
    where
        s = splitOn ": " line

caughtInLayer :: Int -> Int -> Bool
caughtInLayer time depth = mod time (depth*2-2) == 0
        
solve1 :: [(Int, Int)] -> Int
solve1 =
    foldl (\acc (layer, depth) -> if caughtInLayer layer depth then acc+(layer*depth) else acc) 0

solve2 :: [(Int, Int)] -> Int
solve2 input =
    solve2' input 0
    where
        solve2' input delay
            | isCaught = solve2' input (delay+1) 
            | otherwise = delay
            where
                isCaught = foldl (\acc (layer, depth) -> (not acc && caughtInLayer (layer+delay) depth) || acc) False input

main :: IO ()
main = do
    line <- getContents
    let
        input = parseInput line
    print $ solve2 input
    print $ solve1 input
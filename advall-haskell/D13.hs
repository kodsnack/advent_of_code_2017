module D13 where

parseInput :: String -> [(Int,Int)]
parseInput input = 
    map ((\[x,y] -> (read x, read y)) . words) $ lines $ filter (/= ':') input


severity :: Int -> (Int,Int) -> Int
severity delay (x,y)
    | caught delay (x,y) = x * y
    | otherwise          = 0

caught :: Int -> (Int,Int) -> Bool
caught delay (x,y) = ((x + delay) `mod` (2*y -2)) == 0

solve1 :: String -> Int
solve1 input = sum $ map (severity 0) $ parseInput input


solve2' :: Int -> [(Int,Int)] -> Int
solve2' i fw
    | gotCaught = solve2' (i+1) fw
    | otherwise = i
    where gotCaught = or $ map (caught i) fw

solve2 :: String -> Int
solve2 input = solve2' 0 $ parseInput input

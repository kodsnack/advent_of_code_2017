module D2 where

parseInput :: String -> [[Integer]]
parseInput input = map (map read) $ map words $ lines input


solve1 :: String -> Integer
solve1 input = sum $ map rowDiff $ parseInput input
    where rowDiff xs = maximum xs - minimum xs


solve2 :: String -> Integer
solve2 input = sum $ map rowDiff $ parseInput input

rowDiff :: [Integer] -> Integer
rowDiff (x:xs) = case filter (divides x) xs of
    []  -> rowDiff xs
    [y] -> max x y `div` min x y

divides :: Integer -> Integer -> Bool
divides x y = big == (small * intQuotient)
    where   intQuotient = big `div` small 
            big = max x y
            small = min x y

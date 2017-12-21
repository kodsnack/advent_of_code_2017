{-# LANGUAGE BangPatterns #-}
module Main where

solve1 :: Int -> Int
solve1 jumpLength =
    solve1' 0 [0]
    where
        solve1' pos list
            | length list > 2017 = list !! pos
            | otherwise = solve1' (newPos+1) $ take newPos list ++ (length list : drop newPos list)
            where
                newPos = mod (pos + jumpLength) $ length list

solve2 :: Int -> Int
solve2 jumpLength = 
    solve2' 0 1 0
    where
        solve2' pos nextValue !result 
            | nextValue == 50000000 = newResult
            | otherwise = solve2' newPos (nextValue+1) newResult
            where
                newPos = mod (pos + jumpLength) nextValue + 1
                newResult = if newPos == 1 then nextValue else result

main :: IO ()
main = do
    print $ solve1 369
    print $ solve2 369

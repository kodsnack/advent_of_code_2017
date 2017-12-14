module Thirteen
  ( solve
  ) where

parse :: String -> (Int, Int)
parse s = (head l, l !! 1)
  where
    l = map read . words . filter (/= ':') $ s

lengths (depth, range) = (depth, range, range * 2 - 2)

severity (depth, range, loopLength) =
  if depth `mod` loopLength == 0
    then depth * range
    else 0

severity2 delay (depth, range, loopLength) =
  if (depth + delay) `mod` loopLength == 0
    then 1
    else 0

solve1 :: [String] -> Int
solve1 s = sum (map severity l)
  where
    l = map (lengths . parse) s

solve2 :: [String] -> Int
solve2 s = snd . head $ dropWhile ((/=) 0 . fst) $ map f [0 ..]
  where
    l = map (lengths . parse) s
    f delay = (sum (map (severity2 delay) l), delay)

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

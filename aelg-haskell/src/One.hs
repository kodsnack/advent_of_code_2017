module One
  ( solve
  ) where

import           Data.Char

sum' :: [(Char, Char)] -> Int
sum' ((x, y):xs)
  | x == y = digitToInt x + sum' xs
  | otherwise = sum' xs
sum' [] = 0

solve :: [String] -> (String, String)
solve (s:ss) = (show $ sum' $ addLast s, show $ sum' $ zipped s)
  where
    addLast xs = zip xs $ last xs : xs
    zipped s = zip s (drop (length s `div` 2) (double s))
    double = concat . replicate 2

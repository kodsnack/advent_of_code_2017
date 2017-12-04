module Two
  ( solve
  ) where

solve1 = sum . map (diff . map read . words)
  where
    diff xs = maximum xs - minimum xs

solve2 = sum . map (dividers . map read . words)
  where
    dividers (x:xs)
      | divides x xs == (-1) = dividers xs
      | otherwise = divides x xs
      where
        divides a (b:xs)
          | a `rem` b == 0 = a `div` b
          | b `rem` a == 0 = b `div` a
          | otherwise = divides a xs
        divides a [] = -1

solve s = (show $ solve1 s, show $ solve2 s)

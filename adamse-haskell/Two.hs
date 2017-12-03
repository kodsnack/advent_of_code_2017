{-# LANGUAGE TypeApplications #-}
-- |
module Two where

import Data.Maybe (catMaybes)
import Data.List (uncons, tails)

checksum1 sheet = sum . map abs $ zipWith (-) maxs mins
  where
    maxs = map (foldl1 max) sheet
    mins = map (foldl1 min) sheet

checksum2 :: [[Int]] -> Int
checksum2 = sum . map row
  where
    row r = head $ do
      (me, rest) <- catMaybes . map uncons . tails $ r
      oth <- rest
      catMaybes [divs me oth, divs oth me]

divs a b =
  if r == 0
  then Just q
  else Nothing
  where
    (q, r) = quotRem a b

main = do
  inp <- readFile "input2.txt"
  let sheet = fmap (fmap (read @Int) . words) . lines $ inp
  print ("p1", checksum1 sheet)
  print ("p2", checksum2 sheet)

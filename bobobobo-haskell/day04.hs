module Main where

import Data.List

solve1 :: [String] -> Int
solve1 = length . filter id . map (valid.words)
    where
        valid phrase = (length.nub) phrase == length phrase

solve2 :: [String] -> Int
solve2 = length . filter id . map (valid.words)
    where
        valid phrase = length phrase == length ((nub.map sort) phrase)
        

main :: IO ()
main = do
    line <- getContents
    let
        input = lines line
    print $ solve1 input
    print $ solve2 input
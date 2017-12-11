module Main where

import Data.Bits
import Data.List.Split (splitOn, chunksOf)
import Text.Printf (printf)
import Data.List
import qualified Data.Vector.Unboxed as V

reverseSubset :: Int -> Int -> V.Vector Int -> V.Vector Int
reverseSubset start len input =
    V.update_ input idx vals
    where 
        idx =  V.fromList $ map (`mod` V.length input) [start..start+len-1]
        vals = V.backpermute input $ V.reverse idx
        
solve1 :: String -> Int
solve1 input = 
    result V.! 0 * result V.! 1
    where
        (_, _, result) = foldl' (\(startIdx, skip, result) value -> (startIdx+value+skip, skip+1, reverseSubset startIdx value result)) (0, 0, V.fromList [0..255]) $ map read $ splitOn "," input

solve2 :: String -> String
solve2 input =
    chunks >>= printf "%02x".foldl1 xor
    where
        seq = map fromEnum input ++ [17, 31, 73, 47, 23]
        chunks = chunksOf 16 $ V.toList result
        (_, _, result) = foldl' (\acc _ -> round acc) (0, 0, V.fromList [0..255]) [0..63]
        round start = foldl' (\(startIdx, skip, result) value -> (startIdx+value+skip, skip+1, reverseSubset startIdx value result)) start seq

main :: IO ()
main = do
    line <- getLine
    print $ solve1 line
    print $ solve2 line

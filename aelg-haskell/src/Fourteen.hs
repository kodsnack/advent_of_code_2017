module Fourteen
  ( solve
  ) where

import           Data.Bits
import           Data.Char
import           Data.Graph
import           KnotHash

hashInput s i = knotHash $ map ord $ s ++ "-" ++ show i

toBools :: String -> [[Bool]]
toBools s = map (concatMap f . hashInput s) [0..127]
  where f i = map (testBit i) (reverse [0..7] :: [Int])

solve1 :: [String] -> Int
solve1 [s] = sum $ map (sum . map popCount . hashInput s) [0..127]

neighbours (x,y) = [(x+1, y), (x-1,y), (x, y+1), (x,y-1)]

toGraph ll = graph
  where indices = map fst $ filter snd $ zip ((,) <$> [0..127] <*> [0..127]) (concat ll)
        edges = map (\x -> (x,x,neighbours x)) indices
        (graph, _, _) = graphFromEdges edges

solve2 :: [String] -> Int
solve2 [s] = length . components . toGraph . toBools $ s

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

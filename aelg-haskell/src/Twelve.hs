module Twelve
  ( solve
  ) where

import           Data.Graph

parse :: [String] -> (Graph, Vertex -> (Int, Int, [Int]), Int -> Maybe Vertex)
parse = graphFromEdges . map (f . words)
  where
    f l =
      (read $ head l, read $ head l, map (read . filter (/= ',')) $ drop 2 l)

solve1 :: [String] -> Int
solve1 s = length $ reachable graph 0
  where
    (graph, _, _) = parse s

solve2 :: [String] -> Int
solve2 s = length $ components graph
  where
    (graph, _, _) = parse s

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

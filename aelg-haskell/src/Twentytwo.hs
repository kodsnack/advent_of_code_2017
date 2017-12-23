module Twentytwo
  ( solve
  ) where

import qualified Data.Map.Strict as M
import           Grid            as G
import           Util

data Node
  = Infected
  | Clean
  | Weakened
  | Flagged
  deriving (Eq, Show)

type Grid = G.Grid Node

step1 (grid, dir, count, (x, y)) =
  count' `seq` (grid', updateDir cur dir, count', move (updateDir cur dir) (x, y))
  where
    count' = if cur == Clean then count + 1 else count
    grid' = M.alter updateNode (x, y) grid
    updateNode (Just Infected) = Just Clean
    updateNode _               = Just Infected
    updateDir Infected = turnRight
    updateDir Clean = turnLeft
    cur = M.findWithDefault Clean (x, y) grid

step2 (grid, dir, count, (x, y)) =
  count' `seq` (grid', updateDir cur dir, count', move (updateDir cur dir) (x, y))
  where
    count' = if cur == Weakened then count + 1 else count
    grid' = M.alter updateNode (x, y) grid
    updateNode (Just Infected) = Just Flagged
    updateNode (Just Flagged)  = Just Clean
    updateNode (Just Weakened) = Just Infected
    updateNode _               = Just Weakened
    updateDir Infected = turnRight
    updateDir Weakened = id
    updateDir Flagged = turnBack
    updateDir Clean = turnLeft
    cur = M.findWithDefault Clean (x, y) grid

toNode '#' = Infected
toNode '.' = Clean

start s = (length s `div` 2, length (head s) `div` 2)

getInfected (_, _, c, _) = c

solve1 :: [String] -> Int
solve1 s = getInfected $ iterateN 10000 step1 (grid, Up, 0, start s)
  where
    grid = readGrid toNode s

solve2 :: [String] -> Int
solve2 s = getInfected $ iterateN 10000000 step2 (grid, Up, 0, start s)
  where
    grid = readGrid toNode s

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

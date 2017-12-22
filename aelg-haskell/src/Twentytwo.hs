module Twentytwo
  ( solve
  ) where

import qualified Data.Map.Strict as M
import           Prelude         hiding (Left, Right)

data Dir
  = Left
  | Right
  | Up
  | Down
  deriving (Show)

data Node
  = Infected
  | Clean
  | Weakened
  | Flagged
  deriving (Eq, Show)

type Grid = M.Map (Int, Int) Node

turnLeft Left  = Down
turnLeft Down  = Right
turnLeft Right = Up
turnLeft Up    = Left

turnRight Down  = Left
turnRight Right = Down
turnRight Up    = Right
turnRight Left  = Up

turnBack Down  = Up
turnBack Right = Left
turnBack Up    = Down
turnBack Left  = Right

move Left (x, y)  = (x - 1, y)
move Right (x, y) = (x + 1, y)
move Up (x, y)    = (x, y - 1)
move Down (x, y)  = (x, y + 1)

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

readGrid f = go 0
  where
    go y [] = M.empty
    go y (s:ss) = M.union (g y 0 s) (go (y + 1) ss)
      where
        g y x (c:s) = M.insert (x, y) (f c) (g y (x + 1) s)
        g _ _ []    = M.empty

toNode '#' = Infected
toNode '.' = Clean

start s = (length s `div` 2, length (head s) `div` 2)

countInfected (_, _, c, _) = c

-- Strict iteration
iterate' 0 _ x = x
iterate' i f x = x' `seq` iterate' (i-1) f x'
  where
    x' = f x

solve1 :: [String] -> Int
solve1 s = countInfected $ iterate' 10000 step1 (grid, Up, 0, start s)
  where
    grid = readGrid toNode s

solve2 :: [String] -> Int
solve2 s = countInfected $ iterate' 10000000 step2 (grid, Up, 0, start s)
  where
    grid = readGrid toNode s

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

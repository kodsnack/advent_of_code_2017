module Grid (Grid, Pos, Dir (..), readGrid, turnLeft, turnRight, turnBack, move, moveMany, adjacent, adjacentWithDefault) where

import           Prelude         hiding (Left, Right)
import qualified Data.Map.Strict as M
import           Control.Arrow

type Pos = (Int, Int)

type Grid a = M.Map (Int, Int) a

data Dir
  = Left
  | Right
  | Up
  | Down
  deriving (Show, Eq)

turnLeft :: Dir -> Dir
turnLeft Left  = Down
turnLeft Down  = Right
turnLeft Right = Up
turnLeft Up    = Left

turnRight :: Dir -> Dir
turnRight Down  = Left
turnRight Right = Down
turnRight Up    = Right
turnRight Left  = Up

turnBack :: Dir -> Dir
turnBack Down  = Up
turnBack Right = Left
turnBack Up    = Down
turnBack Left  = Right

move :: Dir -> Pos -> Pos
move Left (x, y)  = (x - 1, y)
move Right (x, y) = (x + 1, y)
move Up (x, y)    = (x, y - 1)
move Down (x, y)  = (x, y + 1)

-- Strict iteration
iterate' 0 _ x = x
iterate' i f x = x' `seq` iterate' (i-1) f x'
  where
    x' = f x

moveMany :: Int -> Dir -> Pos -> Pos
moveMany steps dir = iterate' steps (move dir)

adjacent :: Pos -> [Pos]
adjacent (x, y) = map ((+ x) *** (+ y)) ((,) <$> [-1, 0, 1] <*> [-1, 0, 1])

adjacentWithDefault :: a -> Grid a -> Pos -> [a]
adjacentWithDefault def grid = map (flip (M.findWithDefault def) grid) . adjacent

readGrid :: (Char -> a) -> [String] -> Grid a
readGrid f = go 0
  where
    go y [] = M.empty
    go y (s:ss) = M.union (g y 0 s) (go (y + 1) ss)
      where
        g y x (c:s) = M.insert (x, y) (f c) (g y (x + 1) s)
        g _ _ []    = M.empty
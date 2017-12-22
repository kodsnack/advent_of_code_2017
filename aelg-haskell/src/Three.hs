module Three
  ( solve
  ) where

import           Control.Arrow
import           Data.List
import qualified Data.Map.Strict as M
import           Data.Maybe
import           Grid as G

type ShellAndOffset = (Int, Int)

type Order = Int

type IntGrid = G.Grid Int

shellOffset :: Order -> ShellAndOffset
shellOffset = shellOffset' 0
  where
    shellOffset' s offset
      | offset < shellSize = (s, offset)
      | otherwise = shellOffset' (s + 1) (offset - shellSize)
      where
        shellSize = max (s * 8) 1

fromShellAndOffset :: ShellAndOffset -> Pos
fromShellAndOffset (s, offset) = fst $ foldl move (shellStartPos s, offset) dirs
  where
    shellStartPos s = (s, (-s) + 1)
    dirs =
      [ (Down, shellSide - 1)
      , (G.Left, shellSide)
      , (Up, shellSide)
      , (G.Right, shellSide + 1)
      ]
    shellSide = s * 2
    move (pos, offset) (dir, l)
      | offset < l = (moveMany offset dir pos, 0)
      | otherwise = (moveMany l dir pos, offset - l)

pos :: Order -> Pos
pos = fromShellAndOffset . shellOffset

solve1 :: [String] -> Int
solve1 [s] = abs x + abs y
  where
    (x, y) = pos $ read s - 1

updateGrid :: IntGrid -> Order -> (IntGrid, Int)
updateGrid g n = (M.insert (pos n) sumAdjacent g, sumAdjacent)
  where
    sumAdjacent = sum $ adjacentWithDefault 0 g (pos n)

solve2 :: [String] -> Int
solve2 [s] = head $ dropWhile notDone (snd $ mapAccumL updateGrid init [1 ..])
  where
    notDone = (<= read s)
    init = M.singleton (0, 0) 1

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

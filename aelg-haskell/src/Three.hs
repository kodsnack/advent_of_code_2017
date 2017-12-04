module Three
  ( solve
  ) where

import           Control.Arrow
import           Data.List
import qualified Data.Map.Strict as M
import           Data.Maybe

type Pos = (Int, Int)

type ShellAndOffset = (Int, Int)

type Order = Int

type Grid = M.Map Pos Int

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
    shellStartPos s = ((-s) + 1, s)
    dirs =
      [ ((1, 0), shellSide - 1)
      , ((0, -1), shellSide)
      , ((-1, 0), shellSide)
      , ((0, 1), shellSide + 1)
      ]
    shellSide = s * 2
    move ((y, x), offset) ((dy, dx), l)
      | offset < l = ((y + dy * offset, x + dx * offset), 0)
      | otherwise = ((y + dy * l, x + dx * l), offset - l)

pos :: Order -> Pos
pos = fromShellAndOffset . shellOffset

solve1 :: [String] -> Int
solve1 [s] = abs x + abs y
  where
    (x, y) = pos $ read s - 1

updateGrid :: Grid -> Order -> (Grid, Int)
updateGrid g n = (M.insert (pos n) sumAdjacent g, sumAdjacent)
  where
    sumAdjacent = sum $ map (flip (M.findWithDefault 0) g) (adjacent (pos n))
    adjacent (x, y) = map ((+ x) *** (+ y)) ((,) <$> [-1, 0, 1] <*> [-1, 0, 1])

solve2 :: [String] -> Int
solve2 [s] = head $ dropWhile notDone (snd $ mapAccumL updateGrid init [1 ..])
  where
    notDone = (<= read s)
    init = M.singleton (0, 0) 1

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

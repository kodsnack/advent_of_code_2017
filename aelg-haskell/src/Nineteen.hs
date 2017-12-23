module Nineteen
  ( solve
  ) where

import           Grid as G
import           Data.List
import           Data.Maybe
import           Data.Char

start = fromJust . elemIndex '|' . head

getPos s (x,y) = (s !! y) !! x

look :: [String] -> Dir -> (Int, Int) -> (String, Int) -> (String, Int)
look s dir pos ans
  | (dir == Up || dir == Down) && left == '-' = follow s G.Left (move G.Left pos) ans
  | (dir == Up || dir == Down) && right == '-' = follow s G.Right (move G.Right pos) ans
  | (dir == G.Left || dir == G.Right) && up == '|' = follow s Up (move Up pos) ans
  | (dir == G.Left || dir == G.Right) && down == '|' = follow s Down (move Down pos) ans
  | otherwise = ans
  where
    left = getPos s (move G.Left pos)
    right = getPos s (move G.Right pos)
    up = getPos s (move Up pos)
    down = getPos s (move Down pos)

follow :: [String] -> Dir -> (Int, Int) -> (String, Int) -> (String, Int)
follow s dir pos (ans, steps)
  | symbol == '+' = look s dir pos (ans, steps + 1)
  | isLetter symbol = follow s dir (move dir pos) (ans ++ [symbol], steps + 1)
  | symbol == ' ' = (ans, steps)
  | otherwise = follow s dir (move dir pos) (ans, steps + 1)
  where
    symbol = getPos s pos

pad s = [replicate l ' '] ++ map (\x -> " " ++ x ++ " ") s ++ [replicate l ' ']
  where l = 2 + length (head s)

solve1 :: [String] -> String
solve1 s = fst $ follow (pad s) Down (start s + 1, 1) ("", 0)

solve2 :: [String] -> Int
solve2 s = snd $ follow (pad s) Down (start s + 1, 1) ("", 0)

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

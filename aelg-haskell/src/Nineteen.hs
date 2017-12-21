module Nineteen
  ( solve
  ) where

import           Prelude hiding (Left,Right)
import           Data.List
import           Data.Maybe
import           Data.Char


data Dir = Up | Down | Left | Right deriving Eq

start = fromJust . elemIndex '|' . head

getPos s (x,y) = (s !! y) !! x

move Down (x,y) = (x,y+1)
move Up (x,y) = (x,y-1)
move Left (x,y) = (x-1,y)
move Right (x,y) = (x+1,y)

look :: [String] -> Dir -> (Int, Int) -> (String, Int) -> (String, Int)
look s dir pos ans
  | (dir == Up || dir == Down) && left == '-' = follow s Left (move Left pos) ans
  | (dir == Up || dir == Down) && right == '-' = follow s Right (move Right pos) ans
  | (dir == Left || dir == Right) && up == '|' = follow s Up (move Up pos) ans
  | (dir == Left || dir == Right) && down == '|' = follow s Down (move Down pos) ans
  | otherwise = ans
  where
    left = getPos s (move Left pos)
    right = getPos s (move Right pos)
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

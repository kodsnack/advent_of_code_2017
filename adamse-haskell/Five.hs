-- |
module Main where

import Prelude hiding (repeat)
import Control.Monad ((>=>))

data Mem = Mem
  { left :: ![Int]
  , ip :: !Int
  , right :: ![Int]
  } deriving (Show)

initial :: [Int] -> Mem
initial [] = error "Empty instruction list"
initial (i:is) = Mem [] i is

modify :: (Int -> Int) -> Mem -> Mem
modify f mem = mem { ip = f (ip mem) }

next :: Mem -> Maybe Mem
next s = case right s of
  [] -> Nothing
  (x:xs) -> Just Mem
    { left = ip s : left s
    , ip = x
    , right = xs
    }

prev :: Mem -> Maybe Mem
prev s = case left s of
  [] -> Nothing
  (x:xs) -> Just Mem
    { left = xs
    , ip = x
    , right = ip s : right s
    }

repeat :: Int -> (Mem -> Maybe Mem) -> Mem -> Maybe Mem
repeat 0 _ = pure
repeat n f = f >=> repeat (pred n) f

jump :: Int -> Mem -> Maybe Mem
jump n =
  if n >= 0
  then repeat n next
  else repeat (abs n) prev

execute :: (Int -> Int) -> Int -> Mem -> Int
execute f = go
  where
    go steps s =
      maybe steps' (go steps') $
      jump curr s1
      where
        curr = ip s
        s1 = modify f s
        steps' = succ steps

execute1 = execute succ

execute2 = execute f
  where
    f curr =
      if curr >= 3
      then pred curr
      else succ curr

main :: IO ()
main = do
  f <- readFile "input5.txt"
  let ip = initial . map read $ lines f
  print ("p1", execute1 0 ip)
  print ("p2", execute2 0 ip)

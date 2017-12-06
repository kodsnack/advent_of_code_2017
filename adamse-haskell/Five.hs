-- |
module Main where

import Prelude hiding (repeat)

data IP = IP
  { left :: ![Int]
  , current :: !Int
  , right :: ![Int]
  } deriving (Show)

initial :: [Int] -> IP
initial [] = error "Empty instruction list"
initial (i:is) = IP [] i is

modify :: (Int -> Int) -> IP -> IP
modify f ip = ip { current = f (current ip) }

next :: IP -> Maybe IP
next s = case right s of
  [] -> Nothing
  (x:xs) -> Just IP
    { left = current s : left s
    , current = x
    , right = xs
    }

prev :: IP -> Maybe IP
prev s = case left s of
  [] -> Nothing
  (x:xs) -> Just IP
    { left = xs
    , current = x
    , right = current s : right s
    }

repeat :: Int -> (IP -> Maybe IP) -> IP -> Maybe IP
repeat 0 _ = Just
repeat n f = \s -> do
  s' <- f s
  repeat (pred n) f s'

jump :: Int -> IP -> Maybe IP
jump n =
  if n >= 0
  then repeat n next
  else repeat (abs n) prev

execute1 :: Int -> IP -> Int
execute1 steps s =
  maybe steps' (execute1 steps') $
  jump curr s1
  where
    curr = current s
    s1 = modify succ s
    steps' = succ steps

execute2 :: Int -> IP -> Int
execute2 steps s =
  maybe steps' (execute2 steps') $
  jump curr s1
  where
    curr = current s
    f =
      if curr >= 3
      then pred
      else succ
    s1 = modify f s
    steps' = succ steps

main :: IO ()
main = do
  f <- readFile "input5.txt"
  let ip = initial . map read $ lines f
  print ("p1", execute1 0 ip)
  print ("p2", execute2 0 ip)

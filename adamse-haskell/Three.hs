{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE BangPatterns #-}
-- |
module Three where

import Data.Map (Map) -- containers
import qualified Data.Map as Map
import Data.Semigroup (Semigroup(..), Sum(..))
import Data.Maybe (catMaybes)
import Data.List (foldl1')

data Heading
  = N | E | S | W
  deriving (Show, Eq, Enum)

type Pos = (Int, Int)

step :: Heading -> Pos -> Pos
step h (x, y) = case h of
  N -> (x   , y+1)
  E -> (x+1 , y)
  S -> (x   , y-1)
  W -> (x-1 , y)

left :: Heading -> Heading
left h = head $ drop 3 $ dropWhile (/= h) $ cycle [N .. W]

data Spiral a = Spiral
  { heading :: !Heading
  , position :: !Pos
  , values :: !(Map Pos a)
  } deriving (Show)

instance Semigroup (Spiral a) where
  s1 <> s2 = s1 { values = values s1 <> values s2 }

contains :: Spiral a -> Pos -> Bool
contains s pos = Map.member pos (values s)

singl :: Heading -> Pos -> a -> Spiral a
singl head pos val = Spiral head pos (Map.singleton pos val)

sumNabes :: Semigroup a => Pos -> Spiral a -> a
sumNabes p s = foldl1' (<>) . catMaybes . map (flip Map.lookup (values s)) $ nabes p

nabes :: Pos -> [Pos]
nabes p =
  [ step N p
  , step N $ step W p
  , step E p
  , step E $ step N p
  , step S p
  , step S $ step E p
  , step W p
  , step W $ step S p
  ]

s0, s1 :: a -> Spiral a
s0 = singl E (0, 0)
s1 = singl E (1, 0) <> s0

stepS :: Semigroup a => Spiral a -> Spiral a
stepS spiral =
  (if spiral `contains` turny
   then singl hd fwdy (sumNabes fwdy spiral)
   else singl lefthd turny (sumNabes turny spiral))
  <>
  spiral
  where
    turny = step lefthd pos
    fwdy = step hd pos
    pos = position spiral

    lefthd = left hd
    hd = heading spiral

spiralTo :: Int -> Spiral ()
spiralTo 0 = s0 ()
spiralTo 1 = s1 ()
spiralTo n = head $ drop (pred n) (iterate stepS (s1 ()))

firstLarger :: Int -> Spiral (Sum Int)
firstLarger n = head . dropWhile (\s -> getSum (values s Map.! position s) <= n) $ iterate stepS (s1 1)

dist :: Pos -> Pos -> Int
dist (a, b) (x, y) = abs (a - x) + abs (b - y)

sol1 = dist (0,0) . position . spiralTo . pred

sol2 = getSum . (\s -> (values s Map.! position s)) . firstLarger

main = do
  print ("p1", sol1 368078)
  print ("p2", sol2 368078)

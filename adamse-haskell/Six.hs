{-# LANGUAGE ScopedTypeVariables #-}
-- |
module Main where

import Control.Monad.ST (ST, runST)

import Data.Vector (Vector) -- package: vector
import qualified Data.Vector as V
import qualified Data.Vector.Generic.Mutable as M

import Data.Set (Set) -- package: containers
import qualified Data.Set as Set
import Data.Map (Map)
import qualified Data.Map as Map

reallocate :: Vector Int -> Vector Int
reallocate v = runST $ do
  mv <- V.thaw v
  M.write mv maxIx 0
  let go 0 _ = pure ()
      go n (ix:ixs) = M.modify mv (+1) ix >> go (pred n) ixs
  go n ixs
  V.unsafeFreeze mv
  where
    ixs = tail . dropWhile (/= maxIx) . cycle $ [0 .. V.length v - 1]
    maxIx = V.maxIndex v
    n = v V.! maxIx

loop :: a -> (a -> Either a b) -> b
loop st body =
  case body st of
    Left st1 -> loop st1 body
    Right res -> res

sol1 inp = loop (0, Set.empty, inp) $ \(n, seen, v) ->
  let v1 = reallocate v
      n1 = succ n
  in
    if Set.member v1 seen
    then Right n1
    else Left (n1, Set.insert v1 seen, v1)

sol2 inp = loop (0, Map.singleton inp 0, inp) $ \(n, seen, v) ->
  let v1 = reallocate v
      n1 = succ n
  in
    case Map.lookup v1 seen of
      Just n0 -> Right (n1 - n0)
      _ -> Left (n1, Map.insert v1 n1 seen, v1)

main = do
  let banks :: Vector Int = V.fromList . map read . words $ input
  print ("p1", sol1 banks)
  print ("p2", sol2 banks)

input = "10 3 15 10 5 15 5 15 9 2 5 8 5 2 3 6"

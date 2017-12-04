module Util
( get
, pairs
, zipWithIndex
) where

import qualified Data.Maybe

get :: [a] -> Int -> Maybe a
get l i = Data.Maybe.listToMaybe . drop i $ l

pairs :: [a] -> [(a, a)]
pairs [] = []
pairs [a] = []
pairs (a : bs) = (pairWithEach bs a) ++ (pairs bs)
  where
    pairWithEach :: [a] -> a -> [(a, a)]
    pairWithEach bs a = concatMap (\b -> [(a, b), (b, a)]) bs

zipWithIndex :: [a] -> [(a, Int)]
zipWithIndex l = zip l [0..length l - 1]

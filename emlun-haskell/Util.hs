module Util
( get
, zipWithIndex
) where

import qualified Data.Maybe

get :: [a] -> Int -> Maybe a
get l i = Data.Maybe.listToMaybe . drop i $ l

zipWithIndex :: [a] -> [(a, Int)]
zipWithIndex l = zip l [0..length l - 1]

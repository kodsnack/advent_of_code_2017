module Twentyfour
  ( solve
  ) where

import           Data.List
import           Data.Tuple
import           Text.ParserCombinators.ReadP

parse :: [String] -> [(Int, Int)]
parse = map (fst . last . readP_to_S p)
  where
    p = do
      a <- many1 get
      char '/'
      b <- many1 get
      return (read a, read b)

bridges l = go m 0
  where
    m = l ++ map swap l
    go m a
      | null allFitting = [[]]
      | otherwise = concatMap f allFitting
      where
        allFitting = filter ((== a) . fst) m
        f (a,c) = map ((a,c):) $ go nM c
          where
            nM = delete (a,c) $ delete (c,a) m

sumP (a,b) = a+b

strength a = sum (map sumP a)

strongest a b = strength a `compare` strength b

solve1 = maximum . map strength

solve2 = strength . maximumBy comp
  where
    comp a b
      | length a /= length b = length a `compare` length b
      | otherwise = strongest a b

solve :: [String] -> (String, String)
solve s = (show $ solve1 l, show $ solve2 l)
  where l = bridges . parse $ s

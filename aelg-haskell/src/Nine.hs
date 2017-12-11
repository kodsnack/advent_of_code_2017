module Nine
  ( solve
  ) where

import           Control.Arrow
import           Data.List
import qualified Data.Map.Strict as M
import           Data.Maybe

solve1 :: [String] -> Int
solve1 [s] = f 1 s
  where
    f d ('{':xs) = d + f (d + 1) xs
    f d ('}':xs) = f (d - 1) xs
    f d ('<':xs) = f d (g xs)
    f d (_:xs)   = f d xs
    f d []       = 0
    g ('!':_:xs) = g xs
    g ('>':xs)   = xs
    g (_:xs)     = g xs

solve2 :: [String] -> Int
solve2 [s] = f 1 s
  where
    f d ('{':xs) = f (d + 1) xs
    f d ('}':xs) = f (d - 1) xs
    f d ('<':xs) = fst (g xs) + f d (snd (g xs))
    f d (_:xs)   = f d xs
    f d []       = 0
    g ('!':_:xs) = g xs
    g ('>':xs)   = (0, xs)
    g (_:xs)     = (1 + fst (g xs), snd $ g xs)

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

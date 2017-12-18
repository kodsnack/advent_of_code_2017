module Template
  ( solve
  ) where

import           Control.Arrow
import           Data.List
import qualified Data.Map.Strict as M
import           Data.Maybe

--solve1 :: [String] -> String
solve1 = unlines

--solve2 :: [String] -> String
solve2 = solve1

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

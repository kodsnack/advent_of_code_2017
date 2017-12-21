module Five
  ( solve
  ) where

import           Data.List
import           Data.Maybe
import qualified Data.Sequence as S

jump :: (Int -> Int) -> Int -> Int -> S.Seq Int -> Int
jump update x steps l
  | x >= length l || x < 0 = steps
  | otherwise = jump update (x+curOffset) (steps+1) l'
  where curOffset = fromJust $ S.lookup x l
        l' = S.adjust update x l

solve1 :: [String] -> Int
solve1 s = jump (+ 1) 0 0 $ S.fromList $ map read s

solve2 :: [String] -> Int
solve2 s = jump update 0 0 $ S.fromList $ map read s
  where
    update x
      | x >= 3 = x-1
      | otherwise = x + 1

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

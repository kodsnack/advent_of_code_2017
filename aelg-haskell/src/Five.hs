module Five
  ( solve
  ) where

import           Data.List
import           Data.Maybe
import qualified Data.Sequence as S

type Acc = (S.Seq Int, Int, Maybe Int)

f :: (Int -> Int) -> Acc -> Int -> (Acc, (Int, Bool))
f update (s, steps, index) b =
  let i = fromMaybe 0 index
      jump = S.lookup i s
  in ((S.adjust update i s, steps + 1, (+) i <$> jump), (steps, isJust index))

solver :: (Int -> Int) -> [String] -> Int
solver update x =
  let s = S.fromList $ map read x
      (_, acc) = mapAccumL (f update) (s, 0, Just 0) [0 ..]
      a = dropWhile snd acc
      (ans, _) = head a
  in ans - 1

solve1 :: [String] -> Int
solve1 = solver (+ 1)

solve2 :: [String] -> Int
solve2 =
  solver $ \x ->
    if x >= 3
      then x - 1
      else x + 1

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

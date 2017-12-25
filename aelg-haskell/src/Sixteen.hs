module Sixteen
  ( solve
  ) where

import           Data.Foldable
import           Data.List.Split
import           Data.Sequence   ((><))
import qualified Data.Sequence   as S
import qualified Data.Set        as Set

data Op
  = Spin Int
  | Exchange Int
             Int
  | Partner Char
            Char
  deriving (Show)

readOperation ('s':xs) = Spin $ read xs
readOperation ['p', a, '/', b] = Partner a b
readOperation ('x':xs) = Exchange a b
  where
    [(a, s1)] = reads xs
    [(b, _)] = reads $ drop 1 s1

parse [s] = map readOperation l
  where
    l = splitOn "," s

update :: S.Seq Char -> Op -> S.Seq Char
update l (Spin a) = S.drop t l >< S.take t l
  where
    t = S.length l - a
update l (Exchange a b) = S.update a b' $ S.update b a' l
  where
    a' = l `S.index` a
    b' = l `S.index` b
update l (Partner a b) = update l (Exchange aPos bPos)
  where
    Just aPos = S.elemIndexL a l
    Just bPos = S.elemIndexL b l

initial = "abcdefghijklmnop"

billion = 1000000000

solve1 :: [String] -> String
solve1 = toList . foldl update (S.fromList initial) . parse

solve2 :: [String] -> String
solve2 s = toList $ f dances (S.fromList initial) (parse s)
  where
    f 0 l ops = l
    f n l ops = f (n - 1) (foldl update l ops) ops
    findCycleLength n l ops s
      | l `Set.member` s = n
      | otherwise =
        findCycleLength (n + 1) (foldl update l ops) ops (Set.insert l s)
    cycleLength = findCycleLength 0 (S.fromList initial) (parse s) Set.empty
    dances = billion `rem` cycleLength

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

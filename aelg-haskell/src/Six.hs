module Six
  ( solve
  ) where

import qualified Data.Sequence as S
import qualified Data.Set as Set

findLargest :: S.Seq Int -> Int
findLargest xs = res
  where m = maximum xs
        (Just res) = S.elemIndexL m xs

update :: S.Seq Int -> S.Seq Int
update xs = update' (S.adjust (const 0) start xs) (loopIndex (start+1)) (S.index xs start)
  where update' :: S.Seq Int -> Int -> Int -> S.Seq Int
        update' xs' i 0 = xs'
        update' xs' i n = update' (S.adjust (+1) i xs') (loopIndex (i+1)) (n-1)
        loopIndex i = i `mod` S.length xs
        start = findLargest xs

tilDone :: Set.Set (S.Seq Int) -> Int -> S.Seq Int -> (Int, S.Seq Int)
tilDone seen i xs
  | updated `Set.member` seen = (Set.size seen, xs)
  | otherwise = tilDone (Set.insert updated seen) (i+1) updated
  where updated = update xs

solve1 :: String -> Int
solve1 s = 1 + fst (tilDone Set.empty 0 . S.fromList . map read . words $ s)

solve2 :: String -> Int
solve2 s = fst $ tilDone Set.empty 0 endList
  where (_, endList) = tilDone Set.empty 0 . S.fromList . map read . words $ s

solve :: [String] -> (String, String)
solve [s] = (show $ solve1 s, show $ solve2 s)

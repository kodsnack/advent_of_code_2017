module D16 where

import Data.List.Split (splitOn)
import Data.Sequence (Seq, (><), (!?))
import qualified Data.Sequence as S
import Data.Foldable (toList)
import Data.Maybe (fromJust)
import Data.Char (chr, ord)
import Data.Map (Map)
import qualified Data.Map as Map

parseInput :: String -> [String]
parseInput input = splitOn "," input


initSeq :: Seq Int
initSeq = S.fromList $ map ord ['a'..'p']

spin :: Int -> Seq Int -> Seq Int
spin i cs = (S.drop (l - i) cs) >< (S.take (l - i) cs)
    where l = S.length cs

exchange :: (Int,Int) -> Seq Int -> Seq Int
exchange (a,b) cs = S.update a valB $ S.update b valA cs
    where
        valA = fromJust $ cs !? a
        valB = fromJust $ cs !? b

partner :: (Int,Int) -> Seq Int -> Seq Int
partner (a,b) cs = exchange (iA,iB) cs
    where
        iA = fromJust $ S.elemIndexL a cs
        iB = fromJust $ S.elemIndexL b cs

dance :: [String] -> Seq Int -> Seq Int
dance []     cs = cs
dance (m:ms) cs = case m of
    ('s':i)  -> dance ms (spin (read i) cs)
    ('x':ab) -> dance ms (exchange (twoDigitArgs ab) cs)
    ('p':ab) -> dance ms (partner (twoValArgs ab) cs)
    where 
        twoDigitArgs xs = (\[a,b] -> (read a, read b)) $ splitOn "/" xs
        twoValArgs   xs = (\[[a],[b]] -> (ord  a, ord  b)) $ splitOn "/" xs

solve1 :: String -> String
solve1 input = map chr $ toList $ dance (parseInput input) initSeq


danceNTimes :: Int -> Int -> [String] -> Seq Int -> Map (Seq Int) Int -> Seq Int
danceNTimes n i ms cs seen = case Map.lookup cs seen of
    Just iPrev -> res iPrev
    Nothing    -> danceNTimes n (i+1) ms (dance ms cs) (Map.insert cs i seen)
    where 
        res x = fst $ head $ filter ((== (numOfRestRounds x)) . snd) $ Map.toList seen
        numOfRestRounds x = (n - x) `mod` (lenghtCycle x)
        lenghtCycle x = i - x

solve2 :: String -> String
solve2 input = map chr $ toList $ resSeq
    where 
        resSeq = danceNTimes 1000000000 0 ms initSeq Map.empty
        ms = (parseInput input)

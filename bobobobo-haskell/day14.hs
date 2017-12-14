module Main where

import Data.Bits
import Data.List.Split (chunksOf)
import Text.Printf (printf)
import Data.List
import qualified Data.Vector.Unboxed as V
import Data.Maybe
import  Debug.Trace
import qualified Data.Set as S

reverseSubset :: Int -> Int -> V.Vector Int -> V.Vector Int
reverseSubset start len input =
    V.update_ input idx vals
    where 
        idx =  V.fromList $ map (`mod` V.length input) [start..start+len-1]
        vals = V.backpermute input $ V.reverse idx
        
knothash :: String -> String
knothash input =
    chunks >>= printf "%02x".foldl1 xor
    where
        seq = map fromEnum input ++ [17, 31, 73, 47, 23]
        chunks = chunksOf 16 $ V.toList result
        (_, _, result) = foldl' (\acc _ -> round acc) (0, 0, V.fromList [0..255]) [0..63]
        round start = foldl' (\(startIdx, skip, result) value -> (startIdx+value+skip, skip+1, reverseSubset startIdx value result)) start seq

hexToSquares :: Char -> [Bool]
hexToSquares char
    | char == '0' = [False, False, False, False]
    | char == '1' = [False, False, False, True]
    | char == '2' = [False, False, True, False]
    | char == '3' = [False, False, True, True]
    | char == '4' = [False, True, False, False]
    | char == '5' = [False, True, False, True]
    | char == '6' = [False, True, True, False]
    | char == '7' = [False, True, True, True]
    | char == '8' = [True, False, False, False]
    | char == '9' = [True, False, False, True]
    | char == 'a' = [True, False, True, False]
    | char == 'b' = [True, False, True, True]
    | char == 'c' = [True, True, False, False]
    | char == 'd' = [True, True, False, True]
    | char == 'e' = [True, True, True, False]
    | char == 'f' = [True, True, True, True]
    
solve1 :: String -> Int
solve1 input =
    length.filter id$([0..127] >>= (\row -> knothash (input ++ "-" ++ show row)) >>= hexToSquares)

neighbours :: Int -> [Int]
neighbours idx =
    map (\(x,y) -> x+y*128) $ filter (\(x,y) -> x>=0 && x<128 && y>=0 && y<128) [(x+1, y), (x-1, y), (x,y+1), (x,y-1)]
    where
        x = mod idx 128
        y = div (idx-x) 128
    
solve2 :: String -> Int
solve2 input = 
    solve2' v 0 0
    where
        v = V.fromList $([0..127] >>= (\row -> knothash (input ++ "-" ++ show row)) >>= hexToSquares)
        solve2' input idx group =
            case nextIndex of
                Nothing -> group+1
                Just i -> solve2' newInput i group+1
            where
                groupIdx = findGroup input S.empty idx
                newInput = input V.// map (\c -> (c,False)) (S.toList groupIdx)
                nextIndex = V.findIndex id newInput

findGroup :: V.Vector Bool -> S.Set Int -> Int -> S.Set Int
findGroup v ingroup idx  =
    if not value then
        ingroup
    else
        S.foldl' (\acc p -> if not (S.member p acc) then S.union acc (findGroup v acc p) else acc) (S.insert idx ingroup) all
    where
        all = S.fromList $ mapMaybe (\c -> if v V.! c then Just c else Nothing) $ neighbours idx
        value = v V.! idx

main :: IO ()
main = do
    line <- getLine
    print $ solve1 line
    print $ solve2 line
    

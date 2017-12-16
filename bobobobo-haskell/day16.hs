module Main where

import Data.List.Split (splitOn)
import Data.List (foldl')
import qualified Data.Vector.Unboxed as V
import qualified Data.Set as S

startingPositions = V.fromList "abcdefghijklmnop"

parseMove :: String -> V.Vector Char -> V.Vector Char
parseMove str =
        case str of
            ('s':xs) -> spin $ read xs
            ('x':xs) -> let positions = splitOn "/" xs in exchange (read (head positions)) (read (positions!!1))
            ('p':p1:'/':p2:xs) -> partner p1 p2
           
parseMoves :: String -> [V.Vector Char -> V.Vector Char]
parseMoves line =
    map parseMove $ splitOn "," line

spin :: Int -> V.Vector Char -> V.Vector Char
spin l positions=
    right V.++ left
    where
        (left, right) = V.splitAt (V.length positions-l) positions

exchange :: Int -> Int -> V.Vector Char -> V.Vector Char
exchange p1 p2 positions  =
    positions V.// [(p1, positions V.! p2), (p2, positions V.! p1)]

partner :: Char -> Char -> V.Vector Char -> V.Vector Char
partner p1 p2 positions  =
    case (maybePos1, maybePos2) of
        (Just pos1, Just pos2) -> positions V.// [(pos1, positions V.! pos2), (pos2, positions V.! pos1)]
        _ -> positions
    where
        maybePos1 = V.findIndex (p1==) positions
        maybePos2 = V.findIndex (p2==) positions

dance :: V.Vector Char -> [V.Vector Char -> V.Vector Char] -> V.Vector Char
dance = foldl' $ flip ($!)

solve1 :: String -> String
solve1 moves = 
    V.toList $ dance startingPositions $ parseMoves moves

solve2 :: String -> String
solve2 moves =
    V.toList $ foldl' (\acc _ -> dance acc parsedMoves) startingPositions [0..mod 1000000000 cycleLength-1]
    where
        parsedMoves = parseMoves moves
        cycleLength = S.size$solve2' S.empty startingPositions parsedMoves
        solve2' seenPositions partners moves
            | S.member newPositions seenPositions = seenPositions
            | otherwise = solve2' (S.insert newPositions seenPositions) newPositions moves
            where
                newPositions = dance partners moves

main :: IO ()
main = do
    line <- getLine
    print $ solve1 line
    print $ solve2 line

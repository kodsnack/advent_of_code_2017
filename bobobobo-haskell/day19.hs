module Main where

import Data.List (foldl')
import qualified Data.Map.Strict as M
import Data.Maybe
import Prelude hiding (Left, Right)
import Data.Char (isAlpha)

data Direction = Up | Down | Left | Right deriving (Show, Eq)
type Diagram = M.Map (Int, Int) Char
type Coord = (Int, Int)

parse :: String -> Diagram
parse =
    foldl' (\a (y,l) -> foldl' (\a (x,c) -> if c /= ' ' then M.insert (x,y) c a else a) a (zip [0..] l) ) M.empty . zip [0..] . lines

findStartCoord :: Diagram -> Coord
findStartCoord =
    M.foldlWithKey' (\(ax,ay) (x,y) v -> if y==0 then (min x ax, 0) else (ax, ay)) (maxBound :: Int, 0)

move :: Coord -> Direction -> Coord
move (x,y) dir =
    case dir of
        Up -> (x, y-1)
        Down -> (x, y+1)
        Left -> (x-1, y)
        Right -> (x+1, y)

isOkSymbol :: Char -> Bool 
isOkSymbol = (/= ' ')

getSymbol :: Coord -> Diagram -> Char
getSymbol coord =
    fromMaybe ' ' . M.lookup coord

turn :: Coord -> Direction -> Diagram -> Direction
turn coord currentDir diagram=
    foldl' (\a dir -> if isOkSymbol $ getSymbol (move coord dir) diagram then dir else a) currentDir dirsToCheck
    where dirsToCheck = case currentDir of
                            Up -> [Left, Right]
                            Down -> [Left, Right]
                            Left -> [Up, Down]
                            Right -> [Up, Down]

followPath :: Diagram -> Coord -> Direction -> (Char -> a -> a) -> a -> a
followPath diagram coord dir fun result
    | forward = followPath diagram nextCoord dir fun (fun currentChar result)
    | newDir/=dir = followPath diagram coord newDir fun result
    | otherwise = fun currentChar result
    where
        nextCoord = move coord dir
        nextChar = getSymbol nextCoord diagram
        forward = isOkSymbol nextChar
        currentChar = getSymbol coord diagram
        newDir = turn coord dir diagram

solve1 :: Diagram -> String
solve1 diagram = followPath diagram (findStartCoord diagram) Down (\char str -> if isAlpha char then str ++ [char] else str) ""

solve2 :: Diagram -> Int
solve2 diagram = followPath diagram (findStartCoord diagram) Down (\_ count -> count+1) 0

main :: IO ()
main = do
    c <- getContents
    let
        diagram = parse c
    print $ solve1 diagram
    print $ solve2 diagram
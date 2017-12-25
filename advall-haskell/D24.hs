module D24 where

import Data.List (delete)
import Data.List.Split (splitOn)

data Tree = Node Int [Tree] | Leaf Int
type Path = [Int]

parseInput :: String -> Tree
parseInput input = buildTreeFrom (0, map parseLine $ lines input)
    where
        parseLine = (\[x,y] -> (read x, read y)) . splitOn "/"

buildTreeFrom :: (Int, [(Int,Int)]) -> Tree
buildTreeFrom (x,bs)
    | matches == [] = Leaf x
    | otherwise     = Node x (map buildTreeFrom matches)
    where
        matches        = map toNextInp matchingBlocks
        toNextInp p    = (looseEnd p, delete p bs)
        looseEnd (a,b) = if a == x then b else a
        matchingBlocks = filter isMatch bs 
        isMatch (a,b)  = a == x || b == x

maxStrength :: Tree -> Int
maxStrength (Leaf x)          = x
maxStrength (Node x subTrees) = 2 * x + (maximum $ map maxStrength subTrees)


solve1 :: String -> Int
solve1 input = maxStrength $ parseInput input


paths :: Tree -> [Path]
paths (Leaf x)          = [[x]]
paths (Node x subTrees) = map (x :) $ concatMap paths subTrees 

strengthOfLongest :: [Path] -> Int
strengthOfLongest ps = maximum $ map strength longest
    where
        longest       = filter (\p -> length p == longestLength) ps
        longestLength = maximum $ map length ps
        strength p    = sum p + (sum $ init $ tail p)


solve2 :: String -> Int
solve2 input = strengthOfLongest $ paths $ parseInput input

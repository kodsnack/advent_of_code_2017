module D7 where

import Data.Map (Map)
import qualified Data.Map as Map

import Data.List (nub, sortOn, groupBy)

import Data.Ord (comparing)

data Tree = Leaf String Int | Node String Int [Tree]

parseInput1 :: String -> Map String String
parseInput1 input = toChildParentMap Map.empty $ map words $ lines input

toChildParentMap :: Map String String -> [[String]] -> Map String String
toChildParentMap cPMap []                                 = cPMap
toChildParentMap cPMap ([name,weight]:xs)                 = toChildParentMap cPMap xs
toChildParentMap cPMap ((name:weght:"->":[]):xs)          = toChildParentMap cPMap xs
toChildParentMap cPMap ((name:weght:"->":s1:subTrees):xs) = toChildParentMap cPMap' ((name:weght:"->":subTrees):xs)
    where cPMap' = Map.insert (removeComma s1) name cPMap

removeComma :: String -> String
removeComma s = [c | c <- s, c /= ',']

findRoot :: String -> Map String String -> String
findRoot child cPMap = case Map.lookup child cPMap of
    Just parent -> findRoot parent cPMap
    Nothing     -> child

solve1 :: String -> String
solve1 input = findRoot arbNode cPMap
    where arbNode = snd $ head $ Map.toList $ cPMap
          cPMap   = parseInput1 input


parseInput2 :: String -> Tree
parseInput2 input = toTree (toNodeMap Map.empty (map words (lines input))) (solve1 input)

toNodeMap :: Map String (Int, [String]) -> [[String]] -> Map String (Int, [String])
toNodeMap nMap [] = nMap
toNodeMap nMap ([name,weight]:xs) = toNodeMap (Map.insert name (read weight,[]) nMap) xs
toNodeMap nMap ((name:weight:"->":subTrees):xs) = toNodeMap nMap' xs
    where nMap' = Map.insert name (read weight, (map removeComma subTrees)) nMap

weightOfTree :: Tree -> Int
weightOfTree (Leaf _ w) = w
weightOfTree (Node _ w subTrees) = w + sum (map weightOfTree subTrees)

weightOfNode :: Tree -> Int
weightOfNode (Leaf _ w)   = w
weightOfNode (Node _ w _) = w

balancedRoot :: Tree -> Bool
balancedRoot (Leaf _ _) = True
balancedRoot (Node _ w subTrees) = length (nub (map weightOfTree subTrees)) == 1

findUnbalanced :: Tree -> Int
findUnbalanced (Leaf _ _)         = 0
findUnbalanced t@(Node _ w subTrees)
    | balancedRoot t              = sum (map findUnbalanced subTrees)
    | balancedRoot (fst badChild) = (weightOfNode (fst badChild)) + wDiff
    | otherwise                   = findUnbalanced $ fst badChild
    where wDiff                      = (snd goodChild) - (snd badChild)
          [[badChild],(goodChild:_)] = sortOn length grSubTreeWeights
          grSubTreeWeights           = groupBy sndEq $ zip subTrees subTreeWeights
          subTreeWeights             = map weightOfTree subTrees
          sndEq (_,a) (_,b)          = a == b

solve2 :: String -> Int
solve2 input = findUnbalanced $ parseInput2 input

toTree :: Map String (Int, [String]) -> String -> Tree
toTree nodeMap rootName = case Map.lookup rootName nodeMap of
    Just (weight, [])       -> Leaf rootName weight
    Just (weight, children) -> Node rootName weight (map (toTree nodeMap) children)




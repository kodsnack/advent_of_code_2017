module Main where

import Data.List.Split
import Data.List
import Text.Regex.Posix
import qualified Data.Map.Strict as M

parseInput line =
    parse <$> lines line

parse :: String -> (String, String, [String])
parse line =
    (result!!1,result!!2, if result!!4 /= "" then splitOn ", " $ result!!4 else [])
    where
        result = head (line =~ "(.*) \\((.*)\\)( -> )?(.*)?"::[[String]])

getRootName input =
    head $ allNames \\ childNames
    where
        allNames = map name input
        childNames = input >>= children
        name (n, _, _) = n
        children (_, _, c) = c

solve1 = getRootName

data Program = Program Int [Program] deriving (Show)  

solve2 input =
    newWeight
    where
        root = getRootName input
        programs = M.fromList $ map (\(name, weight, children) -> (name, (weight,children))) input

        buildProgramTree root
            | null children = Program (read weight) []
            | otherwise = Program (read weight) (map buildProgramTree children)
            where
                (weight, children) = programs M.! root

        program = buildProgramTree root

        flattenProgramWeights (Program weight children) =
            weight : (children >>= flattenProgramWeights)

        getCorrectWeight diff program
                | wrongValue == rightValue = weight-diff
                | otherwise = case wrongChildNo of
                    Just childNo -> getCorrectWeight (wrongValue-rightValue) $ children!!childNo
                    Nothing -> 0
            where 
                (Program weight children) = program
                weights = map (sum.flattenProgramWeights) children
                groupedWeights = group.sort $ weights
                wrongValue = head.maximum $ groupedWeights
                rightValue = head.minimum $ groupedWeights
                wrongChildNo = elemIndex wrongValue weights

        newWeight = getCorrectWeight 0 program 

main :: IO ()
main = do
    line <- getContents
    let
        input = parseInput line
    print $ solve1 input
    print $ solve2 input
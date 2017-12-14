module Main where

import Data.List.Split
import qualified Data.Map.Strict as M
import qualified Data.Set as S
import Text.Regex.Posix

parseInput :: String -> M.Map String (S.Set String)
parseInput line =
    M.fromList $ parse <$> lines line

parse :: String -> (String, S.Set String)
parse line =
    (result!!1, if result!!2 /= "" then S.fromList (splitOn ", " $ result!!2) else S.empty)
    where
        result = head (line =~ "(.*) <-> (.*)?"::[[String]])

findConnections :: M.Map String (S.Set String) -> String -> S.Set String
findConnections input node =
    M.foldlWithKey' (\acc k v -> if S.notMember node v then acc else S.insert k acc) S.empty input

findConnectionsInGroup :: M.Map String (S.Set String) -> String -> S.Set String
findConnectionsInGroup input startNode =
    findConnectionsInGroup' input (S.singleton startNode) (S.singleton startNode)
    where
        findConnectionsInGroup' input nodes set =
            if newLength == oldLength then
                set
            else
                findConnectionsInGroup' input (S.difference connections set) newConnections
            where
                oldLength = S.size set
                connections = S.foldl' (\acc c -> S.union acc (findConnections input c)) S.empty nodes
                newConnections = S.union set connections
                newLength = S.size newConnections

solve1 :: M.Map String (S.Set String) -> Int
solve1 input = 
    S.size $ findConnectionsInGroup input "0" 

solve2 ::  M.Map String (S.Set String) -> Int
solve2 input = 
    solver input 0
    where
        solver input count =
            if M.size input == 0 then 
                count
            else
                solver (M.withoutKeys input (findConnectionsInGroup input (head $ M.keys input))) (count+1)       

main :: IO ()
main = do
    line <- getContents
    let
        input = parseInput line
    print $ solve1 input    
    print $ solve2 input

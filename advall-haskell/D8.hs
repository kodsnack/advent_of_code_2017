module D8 where

import Data.Map (Map)
import qualified Data.Map as Map

import Data.Char (isDigit)

parseInput :: String -> [[String]]
parseInput input = map words $ lines input


execInstrs :: (Int,Map String Int) -> [[String]] -> (Int,Map String Int)
execInstrs res []                 = res
execInstrs (maxVSeen,vars) (i:is) = execInstrs (maxVSeen', vars') is
    where   maxVSeen' = max maxVSeen (maximum $ map snd $ Map.toList $ vars')
            vars'     = execInstr vars i

execInstr :: Map String Int -> [String] -> Map String Int
execInstr vars [r,op,val,"if",e1,comp,e2] -- assume val and e2 are int values. assume e1 is register name.
    | conditionHolds vars e1 comp e2 = updateVar r op (read val) vars
    | otherwise = vars

updateVar :: String -> String -> Int -> Map String Int -> Map String Int
updateVar r op val vars = Map.insert r (newVal op) vars
    where   newVal "inc" = oldVal + val
            newVal "dec" = oldVal - val
            oldVal       = lookupVar r vars

lookupVar :: String -> Map String Int -> Int
lookupVar r vars = case Map.lookup r vars of
    Just v -> v
    Nothing -> 0 -- if r hasn't been initialized, we assume its value is 0.

conditionHolds :: Map String Int -> String -> String -> String -> Bool
conditionHolds vars e1 fStr e2 = (lookupVar e1 vars) `f` (read e2)
    where   f = head $ [ff | (sf,ff) <- strFMap, sf == fStr]
            strFMap :: [(String, (Int -> Int -> Bool))]            
            strFMap = [  (">" ,(>) ), ("<" ,(<) ), (">=",(>=))
                       , ("<=",(<=)), ("==",(==)), ("!=",(/=)) ]

solve1 :: String -> Int
solve1 input = maximum $ map snd $ Map.toList $ snd $ execInstrs (0, Map.empty)
                       $ parseInput input


solve2 :: String -> Int
solve2 input = fst $ execInstrs (0, Map.empty) $ parseInput input
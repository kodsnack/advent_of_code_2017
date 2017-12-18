module D18 where

import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe (fromJust)

type Program   = Map Int [String]
type Registers = Map Char Int

parseInput :: String -> Program
parseInput input = Map.fromList $ zip [0..] (map words $ lines input)


initRegs :: Registers
initRegs = Map.fromList $ zip ['a'..'z'] [0,0..]

exec1 :: Int -> Program -> Int -> Registers -> Int
exec1 pc p lastV rs = case Map.lookup pc p of
    Just ["snd",[x]  ] 
        -> exec1 (pc+1) p (fromJust (Map.lookup x rs)) rs
    Just ["set",[x],y] 
        -> exec1 (pc+1) p lastV (Map.insert x (parseArg y) rs)
    Just ["add",[x],y] 
        -> exec1 (pc+1) p lastV (Map.adjust (\v -> v + (parseArg y)) x rs)
    Just ["mul",[x],y] 
        -> exec1 (pc+1) p lastV (Map.adjust (\v -> v * (parseArg y)) x rs)
    Just ["mod",[x],y] 
        -> exec1 (pc+1) p lastV (Map.adjust (\v -> v `mod` (parseArg y)) x rs)
    Just ["rcv",[x]  ] 
        -> case Map.lookup x rs of
            Just 0 -> exec1 (pc+1) p lastV rs
            Just _ -> lastV
    Just ["jgz",x,y]   
        -> case (parseArg x) > 0 of
            False -> exec1 (pc+1) p lastV rs
            True  -> exec1 (pc + (parseArg y)) p lastV rs
    where
        parseArg a@(c:cs)
            | c `elem` ['a'..'z'] = fromJust $ Map.lookup c rs
            | otherwise           = read a

solve1 :: String -> Int
solve1 input = exec1 0 (parseInput input) 0 initRegs


type State = (Int,Int,Program,Registers)
type MessageQueue = [Int]

exec2 :: MessageQueue -> MessageQueue -> State -> (MessageQueue,State)
exec2 msIn msOut st@(id,pc,p,rs) = case Map.lookup pc p of
    Just ["snd",[x]  ] 
        -> exec2 msIn (msOut ++ [fromJust (Map.lookup x rs)]) (id, pc+1, p, rs)
    Just ["set",[x],y] 
        -> exec2 msIn msOut (id, pc+1, p, Map.insert x (parseArg y) rs)
    Just ["add",[x],y] 
        -> exec2 msIn msOut (id, pc+1, p, Map.adjust (\v -> v + parseArg y) x rs)
    Just ["mul",[x],y] 
        -> exec2 msIn msOut (id, pc+1, p, Map.adjust (\v -> v * parseArg y) x rs)
    Just ["mod",[x],y] 
        -> exec2 msIn msOut (id, pc+1, p, Map.adjust (\v -> v `mod` parseArg y) x rs)
    Just ["rcv",[x]  ] 
        -> case msIn of
            []     -> (msOut,st)
            (m:ms) -> exec2 ms msOut (id, pc+1, p, Map.insert x m rs)
    Just ["jgz",x,y]   
        -> case (parseArg x) > 0 of
            False  -> exec2 msIn msOut (id, pc+1, p, rs)
            True   -> exec2 msIn msOut (id, pc + (parseArg y), p, rs)
    where
        parseArg a@(c:cs)
            | c `elem` ['a'..'z'] = fromJust $ Map.lookup c rs
            | otherwise           = read a

duet :: (MessageQueue,State) -> (MessageQueue,State) -> Int
duet prevA@(outA,sA) prevB@(outB,sB) 
    | outB == []    = 0
    | getID sB == 1 = length outB + duet prevB (exec2 outB [] sA)
    | otherwise     = 0           + duet prevB (exec2 outB [] sA)

getID :: State -> Int
getID (id,pc,p,rs) = id

solve2 :: String -> Int
solve2 input = duet start0 start1
    where
        start1 = exec2 msOut0 [] (1, 0, parseInput input, Map.insert 'p' 1 initRegs)
        start0@(msOut0,st0) = exec2 [] [] (0, 0, p, initRegs)
        p = parseInput input

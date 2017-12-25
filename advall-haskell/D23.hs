module D23 where

import Data.Map (Map, (!))
import qualified Data.Map as Map
import Data.Numbers.Primes (isPrime)

type Program   = Map Int [String]
type Registers = Map Char Int

parseInput :: String -> Program
parseInput input = Map.fromList $ zip [0..] $ map words $ lines input


initRegs1 :: Registers
initRegs1 = Map.fromList $ zip ['a'..'h'] [0,0..]

initRegs2 :: Registers
initRegs2 = Map.fromList $ zip ['a'..'h'] (1:[0,0..])

exec :: Int -> Int -> Program -> Registers -> (Int,Int)
exec mulCount pc p rs = case Map.lookup pc p of
    Just ["set",[x],y] 
        ->  if (parseArg "a") == 1 && x == 'f' && y == "1" then
                (parseArg "b", parseArg "c")
            else
                exec mulCount (pc+1) p (Map.insert x (parseArg y) rs)
    Just ["sub",[x],y] 
        -> exec mulCount (pc+1) p (Map.adjust (\v -> v - (parseArg y)) x rs)
    Just ["mul",[x],y] 
        -> exec (mulCount +1) (pc+1) p (Map.adjust (\v -> v * (parseArg y)) x rs)
    Just ["jnz",x,y]   
        ->  if (parseArg x) /= 0 then
                exec mulCount (pc + (parseArg y)) p rs
            else
                exec mulCount (pc+1) p rs 
    Nothing 
        -> (mulCount, 0)
    where
        parseArg a@(c:cs)
            | c `elem` ['a'..'h'] = rs ! c
            | otherwise           = read a

solve1 :: String -> Int
solve1 input = fst $ exec 0 0 (parseInput input) initRegs1

-- | inputToPart2 returns the values of registers b and c at the 
-- | point when the first loop is about to start.
inputToPart2 :: String -> (Int,Int) 
inputToPart2 input = exec 0 0 (parseInput input) initRegs2

-- | after the unoptimized code has computed the starting values 
-- | for registers a and b, we stop running it and switch to the
-- | optimized code here in solve2 instead.
solve2 :: String -> Int 
solve2 input = length [b | b <- bs, not (isPrime b)] 
-- ^ h is incremented in every iteration of the outermost loop where b is not prime.
    where
        bs      = [b1, b1+17 .. c1]
        (b1,c1) = inputToPart2 input

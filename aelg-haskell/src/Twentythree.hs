module Twentythree
  ( solve
  ) where

import           Data.Char
import qualified Data.Map.Strict              as M
import           Data.Maybe
import           Data.Numbers.Primes
import           Debug.Trace
import           Text.ParserCombinators.ReadP

type State = M.Map Char Int

data D
  = Register Char
  | Value Int
  deriving (Show)

data Op
  = Snd D
  | Rcv D
  | Set D D
  | Add D D
  | Sub D D
  | Mul D D
  | Mod D D
  | Jgz D D
  | Jnz D D
  deriving (Show)

instance Read Op where
  readsPrec _ =
    readP_to_S $
    choice
      [ string "snd" >> Snd <$> dP
      , string "rcv" >> Rcv <$> dP
      , string "set" >> Set <$> dP <*> dP
      , string "add" >> Add <$> dP <*> dP
      , string "sub" >> Sub <$> dP <*> dP
      , string "mul" >> Mul <$> dP <*> dP
      , string "mod" >> Mod <$> dP <*> dP
      , string "jgz" >> Jgz <$> dP <*> dP
      , string "jnz" >> Jnz <$> dP <*> dP
      ]

valueP = skipSpaces >> Value <$> readS_to_P reads

registerP = skipSpaces >> Register <$> get

dP = valueP <++ registerP

regToInt state (Value x)    = x
regToInt state (Register x) = M.findWithDefault 0 x state

updateRegister state r f = M.alter (Just . maybe (f 0) f) r state

setRegister state r a = M.insert r (regToInt state a) state

lookup' l i
  | i >= 0 && i < length l = Just $ l !! i
  | otherwise = Nothing

runP :: Int -> State -> [Op] -> [Int] -> [Int] -> ([Int], Int, State)
runP pos state ops inQ outQ = runOp $! curOp
  where
    nextAnd newState = runP (pos + 1) newState ops inQ outQ
    popAnd newState = runP (pos + 1) newState ops (tail inQ) outQ
    sendAnd newState d = runP (pos + 1) newState ops inQ (outQ ++ [d])
    jump offset = runP (pos + offset) state ops inQ outQ
    wait = (outQ, pos, state)
    curOp = lookup' ops pos
    runOp Nothing = wait
    runOp (Just (Snd a)) = sendAnd state $ regToInt state a
    runOp (Just (Rcv (Register r))) =
      if null inQ
        then wait
        else popAnd $ setRegister state r (Value $ head inQ)
    runOp (Just (Set (Register r) a)) = nextAnd $ setRegister state r a
    runOp (Just (Add (Register r) a)) =
      nextAnd $ updateRegister state r (+ regToInt state a)
    runOp (Just (Sub (Register r) a)) =
      nextAnd $ updateRegister state r (flip (-) (regToInt state a))
    runOp (Just (Mul (Register r) a)) =
      nextAnd
        (updateRegister (updateRegister state r (* regToInt state a)) 'x' (+ 1))
    runOp (Just (Mod (Register r) a)) =
      nextAnd $ updateRegister state r (`rem` regToInt state a)
    runOp (Just (Jgz r a)) =
      if regToInt state r > 0
        then jump $ regToInt state a
        else nextAnd state
    runOp (Just (Jnz r a)) =
      if regToInt state r /= 0
        then jump $ regToInt state a
        else nextAnd state

solve1 :: [String] -> Int
solve1 s = fromJust $ M.lookup 'x' state
  where
    (_, _, state) = runP 0 M.empty ops [] []
    ops = map read s

-- Cheating, but should work if inputs are similar enough
solve2 :: [String] -> Int
solve2 s = length $ filter (not . isPrime) [start,start + step .. end]
  where
    (Set (Register 'b') (Value b)) = head ops
    (Mul (Register 'b') (Value multiplier)) = ops !! 4
    (Sub (Register 'b') (Value sub)) = ops !! 5
    (Sub (Register 'c') (Value cSub)) = ops !! 7
    (Sub (Register 'b') (Value negStep)) = ops !! (length ops - 2)
    start = b * multiplier - sub
    end = start - cSub
    step = -negStep
    ops = map read s

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

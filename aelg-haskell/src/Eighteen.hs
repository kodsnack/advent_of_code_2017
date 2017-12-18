module Eighteen
  ( solve
  ) where

import           Data.Char
import qualified Data.Map.Strict as M

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
  | Mul D D
  | Mod D D
  | Jgz D D
  deriving (Show)

readD (c:s)
  | isDigit c = Value (read (c : s))
  | c == '-' = Value (read (c : s))
  | otherwise = Register c

parse = map (go . words)
  where
    go ["snd", x]    = Snd (readD x)
    go ["rcv", x]    = Rcv (readD x)
    go ["set", x, y] = Set (readD x) (readD y)
    go ["add", x, y] = Add (readD x) (readD y)
    go ["mul", x, y] = Mul (readD x) (readD y)
    go ["mod", x, y] = Mod (readD x) (readD y)
    go ["jgz", x, y] = Jgz (readD x) (readD y)

regToInt state (Value x)    = x
regToInt state (Register x) = M.findWithDefault 0 x state

updateRegister state r f = M.alter (Just . maybe 0 f) r state

setRegister state r a = M.insert r (regToInt state a) state

runP :: Int -> State -> [Op] -> [Int] -> [Int] -> ([Int], Int, State)
runP pos state ops inQ outQ = runOp curOp
  where
    nextAnd newState = runP (pos + 1) newState ops inQ outQ
    popAnd newState = runP (pos + 1) newState ops (tail inQ) outQ
    sendAnd newState d = runP (pos + 1) newState ops inQ (outQ ++ [d])
    jump offset = runP (pos + offset) state ops inQ outQ
    wait = (outQ, pos, state)
    curOp = ops !! pos
    runOp (Snd a) = sendAnd state $ regToInt state a
    runOp (Rcv (Register r)) =
      if null inQ
        then wait
        else popAnd $ setRegister state r (Value $ head inQ)
    runOp (Set (Register r) a) = nextAnd $ setRegister state r a
    runOp (Add (Register r) a) =
      nextAnd $ updateRegister state r (+ regToInt state a)
    runOp (Mul (Register r) a) =
      nextAnd $ updateRegister state r (* regToInt state a)
    runOp (Mod (Register r) a) =
      nextAnd $ updateRegister state r (`rem` regToInt state a)
    runOp (Jgz r a) =
      if regToInt state r > 0
        then jump $ regToInt state a
        else nextAnd state

solve1 :: [String] -> Int
solve1 s = last sent
  where
    (sent, _, _) = runP 0 M.empty ops [] []
    ops = parse s

solve2 :: [String] -> Int
solve2 s = go 0 (M.singleton 'p' 0) [] 0 (M.singleton 'p' 1) [] 0
  where
    ops = parse s
    go pos0 state0 q0 pos1 state1 q1 noOfSends
      | null send0 && null send1 = noOfSends
      | otherwise = go p0' s0' inQ0 p1' s1' inQ1 (noOfSends + length send1)
      where
        (send0, p0', s0') = runP pos0 state0 ops q0 []
        (send1, p1', s1') = runP pos1 state1 ops q1 []
        inQ0 = send1
        inQ1 = send0

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

module Eight
  ( solve
  ) where

import           Control.Arrow
import           Data.List
import qualified Data.Map.Strict as M
import           Data.Maybe

data Op
  = Inc Int
  | Dec Int

data I = I
  { getReg  :: String
  , getOp   :: Int -> Int
  , getCond :: (String, Int -> Bool)
  }

parse s = I reg theOp (condReg, flip theCond condNum)
  where
    xs = words s
    reg = head xs
    op = xs !! 1
    opSize = read $ xs !! 2
    condReg = xs !! 4
    condOp = xs !! 5
    condNum = read $ xs !! 6
    theOp =
      case op of
        "inc" -> (+ opSize)
        "dec" -> flip (-) opSize
    theCond =
      case condOp of
        "<"  -> (<)
        "<=" -> (<=)
        ">"  -> (>)
        ">=" -> (>=)
        "==" -> (==)
        "!=" -> (/=)

runMachine :: M.Map String Int -> [I] -> (Int, M.Map String Int)
runMachine m (x:xs) = (high, rest)
  where
    f old =
      if cond (fromMaybe 0 $ M.lookup condReg m)
        then Just $ op (fromMaybe 0 old)
        else old
    (condReg, cond) = getCond x
    op = getOp x
    curMachine = M.alter f (getReg x) m
    (h, rest) = runMachine curMachine xs
    high = max h $ M.foldr max 0 curMachine
runMachine m [] = (0, m)

solve1 :: [String] -> Int
solve1 s = M.foldr max 0 finished
  where
    ops = map parse s
    (h, finished) = runMachine M.empty ops

solve2 :: [String] -> Int
solve2 s = h
  where
    ops = map parse s
    (h, finished) = runMachine M.empty ops

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

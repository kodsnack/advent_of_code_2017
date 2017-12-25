module Twentyfive
  ( solve
  ) where

import           Prelude hiding (Left,Right)
import           Data.List
import qualified Data.Map.Strict as M
import           Data.Maybe
import           Data.Char
import           Util
import           Text.ParserCombinators.ReadP
import           Debug.Trace

data Dir = Left | Right deriving (Eq,Show)

data Bit = One | Zero deriving (Eq, Show)

data State =
  State { stateName :: Char
        , getAction :: Bit -> Action
        }

data Action =
  Action { nextState :: Char
         , updateTape :: Tape -> Tape
         }

type States = M.Map Char State

data Tape =
  Tape { getPos :: Int
       , getTape :: M.Map Int Bit
       }

data TuringDesc =
  TuringDesc { checkAfter :: Int
             , curState   :: Char
             , states     :: !States
             }

dirP :: ReadP Dir
dirP = left <++ right
  where
    left = string "left" >> return Left
    right = string "right" >> return Right

bitP :: ReadP Bit
bitP = zero <++ one
  where
    zero = char '0' >> return Zero
    one = char '1' >> return One

actionP :: ReadP Action
actionP = do
  string "If the current value is " >> get >> string ":" >> skipSpaces
  write <- string "- Write the value " >> bitP
  string "." >> skipSpaces
  dir <- string "- Move one slot to the " >> dirP
  string "." >> skipSpaces
  next <- string "- Continue with state " >> get
  string "." >> skipSpaces
  let
    updatePos Left  tape = getPos tape - 1
    updatePos Right tape = getPos tape + 1
    updateTapeF tape = Tape (updatePos dir tape) $ M.insert (getPos tape) write (getTape tape)
  return $! Action next updateTapeF

stateP :: ReadP State
stateP = do
  state <- string "In state " >> get
  string ":" >> skipSpaces
  actionIf0 <- actionP
  actionIf1 <- actionP
  skipSpaces
  let
    getActionF Zero = actionIf0
    getActionF One = actionIf1
  return $! State state getActionF


turingP :: ReadP TuringDesc
turingP = do
  beginState <- string "Begin in state " >> get
  string "." >> skipSpaces
  iterations <- string "Perform a diagnostic checksum after " >> readS_to_P reads
  string " steps." >> skipSpaces
  states <- many stateP
  return $! TuringDesc iterations beginState (M.fromList $ zip (map stateName states) states)

parse = fst . last . readP_to_S turingP

readTape tape = M.findWithDefault Zero (getPos tape) (getTape tape)

run :: TuringDesc -> Tape
run = go (Tape 0 M.empty)
  where
    go :: Tape -> TuringDesc -> Tape
    go tape (TuringDesc 0 _ _) = tape
    go tape (TuringDesc i curState states) = (go $! newTape) next
      where
        state = fromJust $ M.lookup curState states
        next = TuringDesc (i-1) (nextState action) states
        newTape = updateTape action tape
        action = getAction state (readTape tape)

ones tape = length $ M.filter (== One) (getTape tape)

--solve1 :: [String] -> String
solve1 = ones . run

--solve2 :: [String] -> String
solve2 t = "Happy Holidays!"

solve :: [String] -> (String, String)
solve s = (show $ solve1 t, show $ solve2 t)
  where
    t = parse (unlines s)

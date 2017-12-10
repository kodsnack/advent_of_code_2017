import Prelude hiding (LT, GT, EQ)
import qualified Data.Map
import Data.Map (Map, update)
import Data.Maybe (fromJust)

data Operation = Inc | Dec deriving Show
toOperation :: String -> Operation
toOperation "inc" = Inc
toOperation "dec" = Dec

eval :: Operation -> Int -> Int -> Int
eval Inc a b = a + b
eval Dec a b = a - b

data Comparison = LT | LEQ | GT | GEQ | EQ | NEQ deriving Show
toComparison :: String -> Comparison
toComparison "<" = LT
toComparison "<=" = LEQ
toComparison ">" = GT
toComparison ">=" = GEQ
toComparison "==" = EQ
toComparison "!=" = NEQ

test :: Comparison -> Int -> Int -> Bool
test LT  a b = a < b
test LEQ a b = a <= b
test GT  a b = a > b
test GEQ a b = a >= b
test EQ  a b = a == b
test NEQ a b = a /= b

data Command = Command { operand :: String
                       , operation :: Operation
                       , amount :: Int
                       , testand :: String
                       , comparison :: Comparison
                       , reference :: Int
                       } deriving Show

type State = Map String Int

parseCommand :: String -> Command
parseCommand s = Command { operand = op
                         , operation = toOperation inst
                         , amount = read val
                         , testand = testand
                         , comparison = toComparison comp
                         , reference = read ref
                         }
  where
    [op, inst, val, ifword, testand, comp, ref] = take 7 $ words s

execute :: State -> Command -> State
execute state command =
  if test (comparison command) (fromJust . (flip Data.Map.lookup) state . testand $ command) (reference command)
  then update (\v -> Just $ eval (operation command) v (amount command)) (operand command) $ state
  else state

parseCommands :: String -> [Command]
parseCommands = map parseCommand . lines

initialState :: [Command] -> State
initialState = foldl (\state ref -> Data.Map.insert ref 0 state) Data.Map.empty . concatMap references

references :: Command -> [String]
references c = [operand c, testand c]

solveA :: String -> Int
solveA contents = foldl1 max . Data.Map.elems . foldl execute (initialState commands) $ commands
  where
    commands :: [Command]
    commands = parseCommands contents

solveB :: String -> Int
solveB contents = foldl1 max . concatMap Data.Map.elems . scanl execute (initialState commands) $ commands
  where
    commands :: [Command]
    commands = parseCommands contents

main = do
  contents <- getContents

  putStrLn . ("A: " ++) . show . solveA $ contents
  putStrLn . ("B: " ++) . show . solveB $ contents

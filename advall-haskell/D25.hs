module D25 where

import Data.Map.Strict (Map, (!))
import qualified Data.Map.Strict as Map
import Data.List.Split (splitOn)
import Data.List ((!!))


type Pos         = Int
type Val         = Bool
type Move        = Tape -> Tape
type Transitions = Map (Char, Val) (Val, Move, Char)
data Tape        = Tape {pre :: [Val], current :: Val, post :: [Val]} deriving Show

right, left :: Move
right (Tape xs     y []    ) = Tape (y:xs) False []    
right (Tape xs     y (z:zs)) = Tape (y:xs) z     zs    
left  (Tape []     y zs    ) = Tape []     False (y:zs)
left  (Tape (x:xs) y zs    ) = Tape xs     x     (y:zs)

initTape :: Tape
initTape = Tape [] False []

updateCurrent :: Val -> Tape -> Tape
updateCurrent v t = t { current = v }


parseInput :: String -> ((Char, Int), Transitions)
parseInput input = (parseHeader (head $ paragraphs), transitions)
    where
        transitions = Map.fromList $ concatMap parseParagraph (tail $ paragraphs)
        paragraphs  = map (map words) $ splitOn [""] $ lines input


parseHeader :: [[String]] -> (Char, Int)
parseHeader [l1,l2] = (head $ last $ l1, read $ last $ init $ l2)

parseParagraph :: [[String]] -> [((Char, Val), (Val, Move, Char))]
parseParagraph par = [((sName, False), elseRes), ((sName, True), thenRes)]
    where
        sName    = head $ last $ head par
        thenRes  = (thenVal, thenMove, thenSt')
        thenVal  = "1." == (last $ par !! 6)
        thenMove = if last (par !! 7) == "right." then right else left
        thenSt'  = head $ last $ last par
        elseRes  = (elseVal, elseMove, elseSt')
        elseVal  = "1." == (last $ par !! 2)
        elseMove = if last (par !! 3) == "right." then right else left
        elseSt'  = head $ last $ par !! 4


steps :: Int -> (Char, Transitions, Tape) -> Tape
steps 0 (_    , _  , tape) = tape
steps i (state, trs, tape) = steps (i-1) (state', trs, move (updateCurrent val' tape))
    where 
        (val', move, state') = trs ! (state, val)
        val = current tape

solve1 :: String -> Int
solve1 input = checksum $ steps numSteps (startState, trs, initTape)
    where 
        ((startState, numSteps), trs) = parseInput input
        checksum tape = length $ filter id $ pre tape ++ [current tape] ++ post tape

solve2 :: String -> String
solve2 input = "Merry Christmas!"

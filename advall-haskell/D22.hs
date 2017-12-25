module D22 where

import Data.Set (Set)
import qualified Data.Set as Set
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map

type Grid1 = Set Pos
type Pos = (Int, Int)
type Direction = Int

data NodeState = Clean | Weakened | Infected | Flagged
type Grid2 = Map Pos NodeState


parseInput :: String -> (Grid1, Grid2)
parseInput input = (g1,g2)
    where
        g2       = Map.fromSet (\_ -> Infected) g1
        g1       = Set.fromList $ map snd infected
        infected = filter ((== '#') . fst) (zip (concat ls) allPos)
        allPos   = zip (cycle xRange) (concatMap (replicate xLen) yRange)
        xRange   = [-xMax..xMax]
        xMax     = xLen `div` 2
        xLen     = (length $ head ls)
        yRange   = [-yMax..yMax]
        yMax     = (length ls) `div` 2
        ls       = lines input

nSteps1 :: Int -> (Int, Direction, Pos, Grid1) -> Int
nSteps1 0 (infected,_,_,_) = infected
nSteps1 i state            = nSteps1 (i-1) $ step1 state

step1 :: (Int, Direction, Pos, Grid1) -> (Int, Direction, Pos, Grid1)
step1 (infected, face, p@(x,y), g) = (infected', face', p', g')
    where
        p' = move face' p
        (infected', face', g') 
            | Set.member p g = (infected   , (face+1) `mod` 4, Set.delete p g)
            | otherwise      = (infected +1, (face-1) `mod` 4, Set.insert p g)

move :: Direction -> Pos -> Pos
move face (x,y)
    | face == 0 = (x, y-1) -- go north
    | face == 1 = (x+1, y) -- go east
    | face == 2 = (x, y+1) -- go south
    | face == 3 = (x-1, y) -- go west


solve1 :: String -> Int
solve1 input = nSteps1 10000 (0, 0, (0,0), fst $ parseInput input)


nSteps2 :: Int -> (Int, Direction, Pos, Grid2) -> Int
nSteps2 0 (infected,_,_,_) = infected
nSteps2 i state            = nSteps2 (i-1) $ step2 state

step2 :: (Int, Direction, Pos, Grid2) -> (Int, Direction, Pos, Grid2)
step2 (infected, face, p@(x,y), g) = (infected', face', p', g')
    where
        p'                 = move face' p
        (currentState, g') = updateState p g
        (infected', face') = case currentState of
            Clean    -> (infected   , (face-1) `mod` 4)
            Weakened -> (infected +1,  face           )
            Infected -> (infected   , (face+1) `mod` 4)
            Flagged  -> (infected   , (face+2) `mod` 4)

updateState :: Pos -> Grid2 -> (NodeState, Grid2)
updateState p g = case Map.lookup p g of
    Just Clean    -> (Clean   , Map.insert p Weakened g)
    Nothing       -> (Clean   , Map.insert p Weakened g) -- nodes start as clean if not initialized
    Just Weakened -> (Weakened, Map.insert p Infected g)
    Just Infected -> (Infected, Map.insert p Flagged  g)
    Just Flagged  -> (Flagged , Map.insert p Clean    g)
    

solve2 :: String -> Int
solve2 input = nSteps2 10000000 (0, 0, (0,0), snd $ parseInput input)

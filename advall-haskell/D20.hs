module D20 where

import Data.List.Split (splitOneOf)
import Data.List (minimumBy, sort, groupBy, sortOn)
import Data.Ord (comparing)

type State = ((Int,Int,Int),(Int,Int,Int),(Int,Int,Int))
type Id    = Int

parseInput :: String -> [(Id,State)]
parseInput input = zip [0..] $ map parseLine $ lines input
    where 
        parseLine = toTup . (map read) . (filter (/= "")) . (splitOneOf "pva=<>, ")
        toTup [px,py,pz,vx,vy,vz,ax,ay,az] = ((px,py,pz),(vx,vy,vz),(ax,ay,az))

nSteps1 :: Int -> [(Id,State)] -> [(Id,State)]
nSteps1 0 xs = xs
nSteps1 i xs = nSteps1 (i-1) $ map (\(id,s) -> (id, step s)) xs

solve1 :: String -> Id
solve1 input = fst $ minimumBy (comparing manhattanPos) $ nSteps1 10000 $ head 
                   $ groupBy sameManhAcc $ sortOn manhattanAcc $ parseInput input
    where
        manhattanPos (_,(p,_,_)) = manhattan p
        sameManhAcc x y          = manhattanAcc x == manhattanAcc y
        manhattanAcc (_,(_,_,a)) = manhattan a
        manhattan (x,y,z)        = abs x + abs y + abs z

nSteps :: Int -> [State] -> [State]
nSteps 0 ss = ss
nSteps i ss = nSteps (i-1) $ map step $ removeColliding ss

step :: State -> State
step state = updateP $ updateV state
    where
        updateP ((px,py,pz),(vx,vy,vz),a) = ((px+vx,py+vy,pz+vz),(vx,vy,vz),a)
        updateV (p,(vx,vy,vz),(ax,ay,az)) = (p,(vx+ax,vy+ay,vz+az),(ax,ay,az))

removeColliding :: [State] -> [State]
removeColliding ps = concat $ filter ((== 1) . length) $ groupBy samePos $ sort ps
    where 
        samePos s1 s2 = pos s1 == pos s2
        pos (p,v,a)   = p

solve2 :: String -> Int
solve2 input = length $ nSteps 1000 $ map snd $ parseInput input
-- The number of simulated steps here is a bit arbitrary. 
-- All collisions in my input happened during the first 40 steps, 
--   so 1000 seems like a safe guess.

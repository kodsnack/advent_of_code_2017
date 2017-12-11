module D11 where

import Data.List.Split (splitOn)

type Pos = (Integer,Integer,Integer)

parseInput :: String -> [String]
parseInput input = splitOn "," input


steps :: Integer -> Pos -> [String] -> (Integer,Pos)
steps maxDis p []     = (maxDis,p)
steps maxDis p (i:is) = steps maxDis' p' is
    where 
        p' = step p i
        maxDis' = max maxDis (distanceTo p')

step :: Pos -> String -> Pos
step (x,y,z) s = case s of
    "n"  -> (x  ,y+1,z-1)
    "ne" -> (x+1,y  ,z-1)
    "se" -> (x+1,y-1,z  )
    "s"  -> (x  ,y-1,z+1)
    "sw" -> (x-1,y  ,z+1)
    "nw" -> (x-1,y+1,z  )

distanceTo :: Pos -> Integer
distanceTo (x,y,z) = maximum $ map abs $ [x,y,z]

solve1 :: String -> Integer
solve1 input = distanceTo $ snd $ steps 0 (0,0,0) $ parseInput input


solve2 :: String -> Integer
solve2 input = fst $ steps 0 (0,0,0) $ parseInput input

module D19 where

import Data.List (transpose, elemIndex, (!!))
import Data.Maybe (fromJust)

parseInput :: String -> ([String],[String])
parseInput input = (rws,cls)
    where
        cls = transpose rws
        rws = lines input


followMaze :: ([String],[String]) -> ((String,Int),(Int,Int,Int)) -> (String,Int)
followMaze g@(rws,cls) (res@(resS,resI), pos@(x,y,4)) = res
followMaze g@(rws,cls) (res@(resS,resI), pos@(x,y,d)) = followMaze g state'
    where 
        state' = followLine toFollow (res,(x',y',d'))
        toFollow 
            | d' == 0 =           drop y'     $ cls !! x' -- going south
            | d' == 1 = reverse $ take (x'+1) $ rws !! y' -- going west
            | d' == 2 = reverse $ take (y'+1) $ cls !! x' -- going north
            | d' == 3 =           drop x'     $ rws !! y' -- going east
        (x',y',d')
            | d /= 2 && y < (length rws -1) && (cls !! x) !! (y+1) /= ' ' = (x, y+1, 0) -- going south
            | d /= 3 && x > 0               && (rws !! y) !! (x-1) /= ' ' = (x-1, y, 1) -- going west 
            | d /= 0 && y > 0               && (cls !! x) !! (y-1) /= ' ' = (x, y-1, 2) -- going north
            | d /= 1 && x < (length cls -1) && (rws !! y) !! (x+1) /= ' ' = (x+1, y, 3) -- going east 
-- top left corner is at (0,0) and all x,y >= 0

startI :: ([String],[String]) -> ((String,Int),(Int,Int,Int)) -- last triple is (x,y,direction)
startI (rws,cls) = (("",1), (fromJust $ elemIndex '|' (head rws), 0, 1))

followLine :: String -> ((String,Int),(Int,Int,Int)) -> ((String,Int),(Int,Int,Int))
followLine (c:cs) (res@(resS,resI), pos@(x,y,d)) -- c is at index (x,y)
    | c == '+'            = ((resS, resI+1), pos)
    | c `elem` ['A'..'Z'] = followLine cs ((c:resS, resI+1), pos')
    | c `elem` "|-"       = followLine cs (  (resS, resI+1), pos')
    | c == ' '            = (res, (x,y,4)) -- direction 4 means "STOP, reached end of maze"
    where
        pos'
            | d == 0 = (x, y+1, d) -- going south
            | d == 1 = (x-1, y, d) -- going west
            | d == 2 = (x, y-1, d) -- going north
            | d == 3 = (x+1, y, d) -- going east


solve :: String -> (String,Int)
solve input = followMaze maze (startI maze)
    where maze = parseInput input


solve1 :: String -> String
solve1 input = reverse $ fst $ solve input


solve2 :: String -> Int
solve2 input = snd $ solve input

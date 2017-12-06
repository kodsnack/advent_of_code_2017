module D3 where

import Data.Map (Map)
import qualified Data.Map as Map

parseInput :: String -> Integer
parseInput input = read input


solve1 :: String -> Integer
solve1 input = distanceTo $ parseInput input

distanceTo :: Integer -> Integer
distanceTo x = (disToXFrame +) $ minimum $ map (abs . subtract x)  midsOfXFrameSides
    where midsOfXFrameSides = map midOfSide [0..3]
          midOfSide n = (botRightCornerOfXFrame - disToXFrame) - (xFrameSide - 1) * n
          disToXFrame = xFrameSide `div` 2
          (xFrameSide, botRightCornerOfXFrame) = head $ dropWhile (\(a,b) -> b < x) 
                                                      $ map (\i -> (i, i*i)) [1,3..]


solve2 :: String -> Integer
solve2 input = head $ dropWhile (<= (parseInput input)) valSeq

type Grid = Map Pos Val
type Pos = (Integer,Integer)
type Val = Integer

valSeq :: [Val]
valSeq = 1 : valSeq' posSeq (Map.fromList [((0,0),1)])

valSeq' :: [Pos] -> Grid -> [Val]
valSeq' (p:ps) g = v : valSeq' ps g'
    where (v, g') = computeNext p g

computeNext :: Pos -> Grid -> (Val, Grid)
computeNext (x,y) g = (val, Map.insert (x,y) val g)
    where val =   valAt (x-1, y) g   + valAt (x+1, y) g
                + valAt (x, y-1) g   + valAt (x, y+1) g
                + valAt (x-1, y-1) g + valAt (x-1, y+1) g
                + valAt (x+1, y-1) g + valAt (x+1, y+1) g

valAt :: (Integer,Integer) -> Grid -> Integer
valAt pos g = case Map.lookup pos g of
    Just val -> val
    Nothing  -> 0

posSeq :: [Pos]
posSeq = posSeq' [(1,0),(1,1)]
    where posSeq' (a:b:[]) = a : posSeq' (b : [nextPos a b])

nextPos :: Pos -> Pos -> Pos
nextPos (prevX,prevY) (x,y) 
    | x == y && x > 0    = left --top right corner, go left
    | x == y             = right --bottom left corner, go right
    | (-x) == y && y > 0 = down --top left corner, go down
    | x == (-y)          = right --inner bottom right corner, go right
    | x > abs y          = up --outer bottom right corner, go up
    | x < y && prevX > x = left --top side, go left
    | x < y              = down --left side, go down
    | x > y && prevX < x = right --bottom side, go right
    | x > y              = up --right side, go up
    where   up    = (x, y+1)
            down  = (x, y-1)
            right = (x+1, y)
            left  = (x-1, y)






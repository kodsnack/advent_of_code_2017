module Seven
  ( solve
  ) where

import           Data.Function
import           Data.List
import qualified Data.Map.Strict as M
import           Data.Maybe

data Ps = Ps
  { psName     :: String
  , psWeight   :: Int
  , psChildren :: [String]
  } deriving (Show)

data P = P
  { name     :: String
  , weight   :: Int
  , children :: [P]
  } deriving (Show)

parse (x:xs) = Ps (head w) (read (w !! 1)) ch : parse xs
  where
    w = words x
    c = drop 3 w
    ch = map (filter (/= ',')) c
parse [] = []

parentMap :: [Ps] -> M.Map String String
parentMap (ps:pss) = pMap
  where
    (pMap, _) = mapAccumL acc (parentMap pss) (psChildren ps)
    acc m p = (M.insert p (psName ps) m, ())
parentMap [] = M.empty

findRoot :: M.Map String String -> String -> String
findRoot m s =
  case M.lookup s m of
    Just parent -> findRoot m parent
    Nothing     -> s

programMap (ps:pss) = M.insert (psName ps) ps (programMap pss)
programMap []       = M.empty

tower progMap bottom =
  P (psName ps) (psWeight ps) (map (tower progMap) (psChildren ps))
  where
    Just ps = M.lookup bottom progMap

towerWeight p = weight p + sum (map towerWeight (children p))

findOdd t = (map fst . singles) weights
  where
    weights = map towerWeight (children t)
    singles =
      concat .
      filter ((== 1) . length) .
      groupBy ((==) `on` snd) . sortOn snd . zip [0 ..]

findUnbalanced :: P -> P
findUnbalanced t
  | null odd = t
  | otherwise = findUnbalanced (children t !! head odd)
  where
    odd = findOdd t

findTower s p
  | name p == s = [p]
  | otherwise = concatMap (findTower s) (children p)

solve1 :: [String] -> String
solve1 s = findRoot pMap $ psName $ head psList
  where
    psList = parse s
    pMap = parentMap psList

solve2 :: [String] -> Int
solve2 s = weight unbalanced - (towerWeight unbalanced - towerWeight sibling)
  where
    psList = parse s
    pMap = parentMap psList
    progMap = programMap psList
    t = tower progMap (solve1 s)
    unbalanced = findUnbalanced t
    siblings =
      psChildren $
      fromJust (M.lookup (fromJust $ M.lookup (name unbalanced) pMap) progMap)
    sibling =
      head $ concatMap (`findTower` t) (filter (/= name unbalanced) siblings)

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

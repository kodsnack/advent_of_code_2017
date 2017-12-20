module Twenty
  ( solve
  ) where

import           Data.List
import           Data.Maybe
import qualified Data.Set                     as S
import           Text.ParserCombinators.ReadP

type Triple = (Int, Int, Int)

type Particle = (Triple, Triple, Triple)

newtype ParticleP =
  ParticleP Particle

instance Eq ParticleP where
  (ParticleP (a, _, _)) == (ParticleP (b, _, _)) = a == b

instance Ord ParticleP where
  (ParticleP (a, _, _)) `compare` (ParticleP (b, _, _)) = a `compare` b

tripleP :: ReadP Triple
tripleP = do
  skipSpaces
  char '<'
  a <- readS_to_P reads
  char ','
  b <- readS_to_P reads
  char ','
  c <- readS_to_P reads
  char '>'
  return (a, b, c)

particleP :: ReadP Particle
particleP = do
  skipSpaces
  string "p="
  p <- tripleP
  string ", v="
  v <- tripleP
  string ", a="
  a <- tripleP
  return (p, v, a)

parse = map (fst . head . readP_to_S particleP)

maxT (a1, a2, a3) = maximum [abs a1, abs a2, abs a3]

sortP :: Particle -> Particle -> Ordering
sortP (a1, a2, a3) (b1, b2, b3)
  | maxT a3 /= maxT b3 = maxT a3 `compare` maxT b3
  | maxT a2 /= maxT b2 = maxT a2 `compare` maxT b2
  | otherwise = maxT a1 `compare` maxT b1

solve1 :: [String] -> Int
solve1 s = fromJust $ elemIndex p ps
  where
    p = minimumBy sortP ps
    ps = parse s

update :: ParticleP -> ParticleP
update (ParticleP ((p1, p2, p3), (v1, v2, v3), (a1, a2, a3))) =
  ParticleP ((p1', p2', p3'), (v1', v2', v3'), (a1, a2, a3))
  where
    (v1', v2', v3') = (v1 + a1, v2 + a2, v3 + a3)
    (p1', p2', p3') = (p1 + v1', p2 + v2', p3 + v3')

solve2 :: [String] -> Int
solve2 = length . (!! 10000) . iterate tick . sorted
  where
    sorted = sort . map ParticleP . parse
    tick = removeDup . sort . map update
    removeDup = concat . filter ((== 1) . length) . group

solve :: [String] -> (String, String)
solve s = (show $ solve1 s, show $ solve2 s)

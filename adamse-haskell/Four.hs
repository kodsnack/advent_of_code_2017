-- |
module Four where

import qualified Data.Text.Lazy as TL -- text package
import qualified Data.Text.Lazy.IO as TL

import Data.List (group, sort, uncons, tails)
import Data.Maybe (catMaybes)

duplicate (_:_:_) = True
duplicate _ = False

w1 `anagram` w2 =
  sort (TL.unpack w1) == sort (TL.unpack w2)

hasAnagram w = or $ do
  (w1, rest) <- catMaybes . map uncons . tails $ w
  w2 <- rest
  pure (anagram w1 w2)

isValid = not . any duplicate . group . sort

sol1 = length . filter isValid

sol2 = length . filter (not . hasAnagram)

main = do
  f <- TL.readFile "input4.txt"
  let passs = map TL.words . TL.lines $ f

  print ("p1", sol1 passs)
  print ("p2", sol2 passs)

module Main
  ( main
  ) where

import           Control.Exception
import           Data.Maybe
import qualified One
import           System.Environment
import qualified Two

solve f s = do
  let (a1, a2) = f $ lines s
  putStrLn a1
  putStrLn a2

maybeRead = fmap fst . listToMaybe . reads

main = do
  arg <- fmap listToMaybe getArgs
  s <- getContents
  let ms = arg >>= maybeRead
  case ms of
    Just 1 -> solve One.solve s
    Just 2 -> solve Two.solve s
    _      -> putStrLn "Usage : aoc <millisecond>"

module Util (iterateN) where

-- Strict iteration
iterateN 0 _ x = x
iterateN i f x = iterateN (i-1) f $! f x
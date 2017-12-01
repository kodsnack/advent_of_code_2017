import Data.Char ( digitToInt )

-- baserat på en sträng av siffror
-- ta fram alla siffror som matchar nästa siffra
-- och summera dem
getSumOfMatchers :: String -> Int
-- 1. gå igenom strängen, titta på nuvarande tecken och nästa
-- 2. i fall de är samma, returnera summan av dem + funktionen igen
-- 3. annars returnera funktionen igen
getSumOfMatchers ""       = 0
getSumOfMatchers (a:"")   = 0
getSumOfMatchers aa@(a:_) = getSumOfMatchers' aa a
  where
    getSumOfMatchers' ""       _       = 0
    getSumOfMatchers' (a:"")   first   = summer (digitToInt a) (digitToInt first)
    getSumOfMatchers' (a:b:as) first   = summer (digitToInt a) (digitToInt b)
                                         + getSumOfMatchers' (b:as) first
    summer a b | a == b    = a
               | otherwise = 0

sumHalfwayThrough :: String -> Int
sumHalfwayThrough ""       = 0
sumHalfwayThrough (a:"")   = 0
sumHalfwayThrough aa = sumHalfwayThrough' aa 0
  where
    sumHalfwayThrough' l pos | pos >= length l = 0
                             | otherwise       = summer (digitToInt a) (digitToInt b)
                                                 + sumHalfwayThrough' l (pos + 1)
      where
        a = l !! pos
        b = (l ++ l) !! (pos + (length l `div` 2))
        summer a b | a == b    = a
                   | otherwise = 0

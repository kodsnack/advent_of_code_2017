module D9 where

clean :: String -> (String,String)
clean s = (good, bad)
    where
        good = concatMap fst tupLst
        bad = concatMap snd tupLst
        tupLst = clean' s

clean' :: String -> [(String,String)]
clean' "" = []
clean' s  = (good, garbage) : clean' nextGood
    where 
        (garbage,nextGood) = removeGarbage "" badAndFurther
        badAndFurther = drop (1 + length good) s
        good          = takeWhile ((/=) '<') s
        removeGarbage _ "" = ("", "")
        removeGarbage g (x:xs)
            | x == '!'  = removeGarbage g $ tail xs
            | x == '>'  = (g, xs)
            | otherwise = removeGarbage (x:g) xs

score :: Int -> String -> Int
score _ "" = 0
score level (x:xs)
    | x == '{' = level + (score (level + 1) xs)
    | x == '}' = score (level - 1) xs
    | otherwise = score level xs

solve1 :: String -> Int
solve1 input = score 1 $ fst $ clean input


solve2 :: String -> Int
solve2 input = length $ snd $ clean input

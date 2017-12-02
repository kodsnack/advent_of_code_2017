split :: Char -> String -> [String]
split c ""     = []
split c (s:ss) | c == s    = [] : split c ss
               | otherwise = [s : first] ++ rest
                 where
                   all = split c ss
                   first = if (length all) > 0 then head all else []
                   rest  = if (length all) > 1 then tail all else []

toTable :: String -> [[Int]]
toTable s = map ((map read) . (split '\t')) $ split '\n' s

checkSum :: String -> Int
checkSum s = sum $ map diffMinmax $ toTable s
  where
    diffMinmax l = maximum l - minimum l

main :: IO ()
main = do
  input <- readFile "./second-input"
  print $ checkSum input



rows = "5 1 9 5\
\\n7 5 3\
\\n2 4 6 8"
uglyTest1 = checkSum rows == 18

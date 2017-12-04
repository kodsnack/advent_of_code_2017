toTable :: String -> [[Int]]
toTable s = map ((map read) . words) $ lines s

checkSum :: String -> Int
checkSum s = sum $ map diffMinmax $ toTable s
  where
    diffMinmax l = maximum l - minimum l

getDivisible :: [Int] -> (Int, Int)
getDivisible l = head [ ((max a b), (min a b))
                      | a <- l, b <- l, (a `mod` b == 0) && (a /= b)]

checkDivisibleSum :: String -> Int
checkDivisibleSum s = sum $ map ((\(a, b) -> a `div` b) . getDivisible) (toTable s)

main :: IO ()
main = do
  input <- readFile "./second-input"
  putStrLn "Första stjärnan"
  print $ checkSum input
  putStrLn "Andra stjärnan"
  print $ checkDivisibleSum input



rows = "5\t1\t9\t5\
\\n7\t5\t3\
\\n2\t4\t6\t8"
uglyTest1 = checkSum rows == 18


rows2 = "5\t9\t2\t8\
\\n9\t4\t7\t3\
\\n3\t8\t6\t5"
uglyTest2 = checkDivisibleSum rows2 == 9

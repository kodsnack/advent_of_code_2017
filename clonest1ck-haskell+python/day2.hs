main :: IO ()
main = interact(checksum)

checksum :: String -> String
checksum s = "Task 1 " ++ checksum_task1 s ++ "Task 2 " ++ checksum_task2 s

checksum_task1 :: String -> String
checksum_task1 s = show (sum (map maxplusmin (map parseint (map words (lines s))))) ++ "\n"

checksum_task2 :: String -> String
checksum_task2 s = show (sum (map (evenlydivisible . parseint) (map words (lines s)))) ++ "\n"

parseint :: [String] -> [Int]
parseint x = map read x

maxplusmin :: [Int] -> Int
maxplusmin xs = maximum xs - minimum xs

evenlydivisible :: [Int] ->  Int
evenlydivisible (x:xs) = divisible (mergelists (x:xs) xs)

divisible :: [(Int,Int)] -> Int
divisible []                                           = 0
divisible ((x,y):xs) | x < y && x /= 0 && mod y x == 0 = div y x
                     | x > y && y /= 0 && mod x y == 0 = div x y
                     | otherwise                       = divisible xs

mergelists :: [a] -> [a] -> [(a,a)]
mergelists [] _          = []
mergelists (x:[])   []   = []
mergelists (x:y:xs) []   = mergelists (y:xs) xs
mergelists (x:xs) (y:ys) = (x, y) : mergelists (x:xs) ys

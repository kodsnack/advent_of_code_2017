import Data.List

main :: IO ()
main = interact (solve)

solve :: String -> String
solve xs = solve_first xs ++ solve_second xs

solve_first :: String -> String
solve_first s = show (sum (map (duplicate . sort) (map words (lines s)))) ++ "\n"

solve_second :: String -> String
solve_second s = show (sum (map (duplicate . sort . (map sort)) (map words (lines s)))) ++ "\n"

duplicate :: [String] -> Int
duplicate (x:[])   = 1
duplicate (x:y:xs) | x == y    = 0
                   | otherwise = duplicate (y:xs)

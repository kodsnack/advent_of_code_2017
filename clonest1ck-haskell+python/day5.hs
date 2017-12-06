main :: IO ()
main = interact(jumps)

jumps :: String -> String
jumps s = "Task 1: " ++ show (run_program (parseint (lines s)) (length (lines s)) 0 0 inc_1) ++ "\nTask 2: " ++ show (run_program (parseint (lines s)) (length (lines s)) 0 0 complex) ++ "\n"

run_program :: [Int] -> Int -> Int -> Int -> (Int -> Int) -> Int
run_program mem l pc count offs | l <= pc    = count
                                | otherwise  = run_program (edit_mem mem pc offs) l (pc + mem!!pc) (count + 1) offs

edit_mem :: [Int] -> Int -> (Int -> Int) -> [Int]
edit_mem []     a b    = []
edit_mem (x:xs) 0 func = (func x) : xs
edit_mem (x:xs) p func = x : edit_mem xs (p - 1) func

inc_1 :: Int -> Int
inc_1 x = x + 1

complex :: Int -> Int
complex x | x >= 3 = x - 1
          | otherwise = x + 1

parseint :: [String] -> [Int]
parseint x = map read x

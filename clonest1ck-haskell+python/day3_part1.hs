
solve_first :: Int -> Int
solve_first 1 = 0
solve_first x = findLayer x 1 3

findLayer :: Int -> Int -> Int -> Int
findLayer x y z | x > y^2 && x <= z^2  = findLoc (mod x (z - 1)) z 1 1
                | otherwise            = findLayer x (y + 2) (z + 2)

findLoc :: Int -> Int -> Int -> Int -> Int
findLoc x y c1 c2 | x == c1 || x == c2 = y - c2
                  | otherwise          = findLoc x y (mod (c1 - 1) (y -1)) (c2 + 1)

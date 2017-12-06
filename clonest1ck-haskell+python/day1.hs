

solve_first :: Integral x => x -> x
solve_first x = add_duplicates (parse x)

solve_second :: Integral x => x -> x
solve_second x =
    add_duplicates_halfway
        ((drop (div(length (digits x)) 2) (digits x)) ++ (take (div(length (digits x)) 2) (digits x)))
        (digits x)

add_duplicates_halfway :: Integral x => [x] -> [x] -> x
add_duplicates_halfway [] _                      = 0
add_duplicates_halfway _ []                      = 0
add_duplicates_halfway (x:xs) (y:ys) | x == y    = x + add_duplicates_halfway xs ys
                                     | otherwise = add_duplicates_halfway xs ys


add_duplicates :: Integral x => [x] -> x
add_duplicates []                   = 0
add_duplicates (x:[])               = 0
add_duplicates (x:y:xs) | x == y    = x + add_duplicates (y:xs)
                        | otherwise = add_duplicates (y:xs)

parse :: Integral x => x -> [x]
parse 0 = [0,0]
parse x = (mod x 10) : digits x

digits :: Integral x => x -> [x]
digits 0 = []
digits x = digits (div x 10) ++ [mod x 10]

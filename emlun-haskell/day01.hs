import qualified Data.Char

solve :: Int -> [Int] -> Int
solve lookahead digits = sum matches
  where
    matches :: [Int]
    matches = fst . unzip . filter (uncurry (==)) $ zip digits rotated

    rotated :: [Int]
    rotated = uncurry (flip (++)) $ splitAt lookahead digits

main = do
  contents <- getContents
  let digits = map Data.Char.digitToInt . filter Data.Char.isDigit $ contents

  putStrLn $ "A: " ++ (show $ solve 1 digits)
  putStrLn $ "B: " ++ (show $ solve (div (length digits) 2) digits)

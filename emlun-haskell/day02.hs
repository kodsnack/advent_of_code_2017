import Data.List (find)
import Data.Maybe (fromJust)
import Util (pairs)

solve :: String -> ([Int] -> Int) -> Int
solve stdin metric = sum . map metric . rows $ stdin
  where
    rows :: String -> [[Int]]
    rows s = map (map (read :: String -> Int). words). lines $ s

spread :: [Int] -> Int
spread nums = (foldl1 max nums) - (foldl1 min nums)

quotient :: [Int] -> Int
quotient = uncurry div . fromJust . find ((== 0) . uncurry mod) . pairs

main = do
  contents <- getContents

  putStrLn $ "A: " ++ (show $ solve contents spread)
  putStrLn $ "B: " ++ (show $ solve contents quotient)

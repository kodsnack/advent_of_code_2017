import qualified Data.List
import qualified Data.Maybe

solve :: String -> ([Int] -> Int) -> Int
solve stdin metric = sum . map metric . rows $ stdin
  where
    rows :: String -> [[Int]]
    rows s = map (map (read :: String -> Int). words). lines $ s

spread :: [Int] -> Int
spread nums = (foldl1 max nums) - (foldl1 min nums)

quotient :: [Int] -> Int
quotient nums = nonzeroQuotient . Data.Maybe.fromJust . Data.List.find divisible . pairs $ nums
  where
    divisible :: (Int, Int) -> Bool
    divisible (a, b) = (mod a b) == 0 || (mod b a) == 0

    nonzeroQuotient :: (Int, Int) -> Int
    nonzeroQuotient (a, b)
      | a > b = div a b
      | otherwise = div b a

pairs :: [a] -> [(a, a)]
pairs [] = []
pairs [a] = []
pairs (a : bs) = (pairWithEach bs a) ++ (pairs bs)
  where
    pairWithEach :: [a] -> a -> [(a, a)]
    pairWithEach bs a = map (\b -> (a, b)) bs

main = do
  contents <- getContents

  putStrLn $ "A: " ++ (show $ solve contents spread)
  putStrLn $ "B: " ++ (show $ solve contents quotient)

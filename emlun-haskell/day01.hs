import qualified Util
import qualified Data.Char

solve :: Int -> [Int] -> Int
solve lookahead digits = sum matches
  where
    matches :: [Int]
    matches = map fst . filter sameDigitAsLookahead . Util.zipWithIndex $ digits

    sameDigitAsLookahead :: (Int, Int) -> Bool
    sameDigitAsLookahead (digit, index) = (Just digit) == (Util.get digits $ mod (index + lookahead) (length digits))

main = do
  contents <- getContents
  let digits = map Data.Char.digitToInt . filter Data.Char.isDigit $ contents

  putStrLn $ "A: " ++ (show $ solve 1 digits)
  putStrLn $ "B: " ++ (show $ solve (div (length digits) 2) digits)

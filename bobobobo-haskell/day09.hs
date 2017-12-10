module Main where

data State = Group | Garbage | Ignore State deriving (Show)
data Result = Result { state :: State
                     , level :: Int 
                     , levelsum :: Int
                     , garbage :: Int } deriving (Show)

run :: String -> Result
run =
    foldl handleChar (Result Group 0 0 0)

handleChar :: Result -> Char -> Result
handleChar (Result state level levelsum garbage) c =
    case (state, c) of
        (Group, '{') -> Result Group (level+1) levelsum garbage
        (Group, '}') -> Result Group (level-1) (levelsum+level) garbage
        (Group, '<') -> Result Garbage level levelsum garbage
        (Garbage, '>') -> Result Group level levelsum garbage
        (Ignore lastState, _) -> Result lastState level levelsum garbage
        (_, '!') -> Result (Ignore state) level levelsum garbage
        (Garbage, _) -> Result Garbage level levelsum (garbage+1)
        (_, _) -> Result Group level levelsum garbage
        

main :: IO ()
main = do
    c <- getContents
    let
        result = run c
    
    print $ levelsum result
    print $ garbage result
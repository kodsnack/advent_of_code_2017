module Main where

import qualified Data.Map.Strict as M
import Data.Maybe

type Registers = M.Map String Int 

data Instruction = Instruction { register :: String
                                , operation :: Int -> Int
                                , compareRegister :: String
                                , compareFunction :: Int -> Int -> Bool
                                , compareValue :: Int
                                } 

parseOperation :: String -> String -> Int -> Int
parseOperation op v=
    if op == "inc" then (+) $ read v else flip (-) $ read v

parseCondition :: String -> Int -> Int -> Bool
parseCondition str =
    case str of
        ">" -> (>)
        "<" -> (<)
        "==" -> (==)
        "!=" -> (/=)
        ">=" -> (>=)
        "<=" -> (<=)

parseInstruction :: String -> Instruction
parseInstruction line =
    Instruction (w!!0) (parseOperation (w!!1) (w!!2)) (w!!4) (parseCondition $ w!!5) (read $ w!!6)
    where
        w = words line

parseInput :: String -> [Instruction]
parseInput input =
    parseInstruction <$> lines input

run :: Registers -> Instruction -> (Int, Registers)
run registers instruction
    | compare compareRegisterValue compareValue = (operation registerValue, M.insert register (operation registerValue) registers)
    | otherwise = (registerValue, registers)
    where
        (Instruction register operation compareRegister compare compareValue) = instruction
        registerValue = fromMaybe 0 $ M.lookup register registers
        compareRegisterValue = fromMaybe 0 $ M.lookup compareRegister registers
        
solve1 :: [Instruction] -> Int
solve1 input=
    maximum $ map snd $ M.toList $ foldl (\r i -> snd $ run r i) M.empty input

solve2 :: [Instruction] -> Int
solve2 input =
    fst $ foldl run' (0, M.empty) input 
    where
        run' (m, r) i =
            (max v m, r2)
            where
                (v,r2) = run r i
                
main :: IO ()
main = do
    c <- getContents
    let
        input = parseInput c
    
    print $ solve1 input
    print $ solve2 input
module Main where

import qualified Data.Map.Strict as M
import Data.Maybe
import Debug.Trace

data Value = Static Int | Register String deriving (Show)
data Instruction = Snd Value | Set String Value | Add String Value | Mul String Value | Mod String Value | Rcv String | Jgz Value Value deriving (Show)
data Cpu = Cpu { prmPointer :: Int
               , registers :: M.Map String Int
               , inData :: [Int]
               } deriving (Show)
parse content =
    map parseInstruction $ lines content

parseInstruction line =
    case words line of
        ("snd":value:xs) -> Snd $ parseValue value
        ("set":register:value:xs) -> Set register $ parseValue value
        ("add":register:value:xs) -> Add register $ parseValue value
        ("mul":register:value:xs) -> Mul register $ parseValue value
        ("mod":register:value:xs) -> Mod register $ parseValue value
        ("rcv":register:xs) -> Rcv register
        ("jgz":value1:value2:xs) -> Jgz (parseValue value1) (parseValue value2)
        

readMaybe :: Read a => String -> Maybe a
readMaybe s = case reads s of
                    [(val, "")] -> Just val
                    _           -> Nothing

parseValue v =
    case maybeStatic of
        Just static -> Static static
        Nothing -> Register v
    where
        maybeStatic = readMaybe v :: Maybe Int

executeInstruction_part1 prgmPointer program registers sndData =
    case instruction of
        Snd freq -> (prgmPointer+1, registers, [getValue freq registers], [])
        Set register value -> (prgmPointer+1, M.insert register (getValue value registers) registers, sndData, [])
        Add register value -> (prgmPointer+1, M.insert register (getRegisterValue register registers+getValue value registers) registers, sndData, [])
        Mul register value -> (prgmPointer+1, M.insert register (getRegisterValue register registers*getValue value registers) registers, sndData, [])
        Mod register value -> (prgmPointer+1, M.insert register (getRegisterValue register registers `mod` getValue value registers) registers, sndData, [])
        Rcv register -> (prgmPointer+1, registers, if not (null sndData) then drop 1 sndData else sndData, [sndData !! 0])
        Jgz value1 value2 -> (if getValue value1 registers>0 then prgmPointer+getValue value2 registers else prgmPointer+1, registers, sndData, [])
    where
        instruction = program !! prgmPointer

execute_part1 program cpu =
    if length newOutData > 0 then
        newOutData !! 0
    else
        execute_part1 program (Cpu nextInstruction newRegisters newInData)
    where
        (nextInstruction, newRegisters, newInData, newOutData) = executeInstruction_part1 (prmPointer cpu) program (registers cpu) (inData cpu)

executeInstruction prgmPointer program registers inData =
    case instruction of
        Snd value -> (prgmPointer+1, M.insert "sent" (getRegisterValue "sent" registers+1) registers, inData, [getValue value registers])
        Set register value -> (prgmPointer+1, M.insert register (getValue value registers) registers, inData, [])
        Add register value -> (prgmPointer+1, M.insert register (getRegisterValue register registers+getValue value registers) registers, inData, [])
        Mul register value -> (prgmPointer+1, M.insert register (getRegisterValue register registers*getValue value registers) registers, inData, [])
        Mod register value -> (prgmPointer+1, M.insert register (getRegisterValue register registers `mod` getValue value registers) registers, inData, [])
        Rcv register -> (if not (null inData) then prgmPointer+1 else prgmPointer, if not (null inData) then M.insert register (head inData) registers else registers, if not (null inData) then drop 1 inData else inData, [])
        Jgz value1 value2 -> (if getValue value1 registers>0 then prgmPointer+getValue value2 registers else prgmPointer+1, registers, inData, [])
    where
        instruction = program !! prgmPointer
             
execute program cpu1 cpu2 =
    if waitingCpu1 && waitingCpu2 then
        (cpu1, cpu2)
    else
        execute program (Cpu nextInstruction1 newRegisters1 (newInData1++newOutData2)) (Cpu nextInstruction2 newRegisters2 (newInData2++newOutData1))
    where
        waitingCpu1 = isWaiting cpu1 program
        waitingCpu2 = isWaiting cpu2 program
        (nextInstruction1, newRegisters1, newInData1, newOutData1) = executeInstruction (prmPointer cpu1) program (registers cpu1) (inData cpu1)
        (nextInstruction2, newRegisters2, newInData2, newOutData2) = executeInstruction (prmPointer cpu2) program (registers cpu2) (inData cpu2)

isWaiting cpu program =
    case program !! prmPointer cpu of
        Rcv _ -> null (inData cpu)
        _ -> False

getValue value registers =
    case value of
        Static v -> v
        Register r -> getRegisterValue r registers

getRegisterValue register registers = fromMaybe 0 (M.lookup register registers)

main :: IO ()
main = do
    c <- getContents
    print $ execute_part1 (parse c) (Cpu 0 (M.empty) [])
    print $ getRegisterValue "sent" $ registers $ snd $ execute (parse c) (Cpu 0 (M.singleton "p" 0) []) (Cpu 0 (M.singleton "p" 1) [])
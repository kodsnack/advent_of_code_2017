module Day5 exposing (..)

import Regex
import Array exposing (Array)


parseInput : String -> List Int
parseInput x =
    x
        |> String.trim
        |> String.lines
        |> List.map String.trim
        |> List.map String.toInt
        |> List.map Result.toMaybe
        |> List.filterMap identity


part1 : String -> Int
part1 input =
    exec1 (Array.fromList (parseInput input)) 0 0


part2 : String -> Int
part2 input =
    exec2 (Array.fromList (parseInput input)) 0 0


exec1 : Array Int -> Int -> Int -> Int
exec1 instructions frame n =
    case Array.get frame instructions of
        Just i ->
            exec1 (Array.set frame (i + 1) instructions) (frame + i) (n + 1)

        Nothing ->
            n


exec2 : Array Int -> Int -> Int -> Int
exec2 instructions frame n =
    case Array.get frame instructions of
        Just i ->
            let
                newFrame =
                    if i > 2 then
                        i - 1
                    else
                        i + 1
            in
                exec2 (Array.set frame newFrame instructions) (frame + i) (n + 1)

        Nothing ->
            n

module Day2 exposing (..)

import Regex


part1 input =
    solution (parseInput input)


part2 input =
    solution2 (parseInput input)


parseRow : String -> List Int
parseRow x =
    x
        |> Regex.split Regex.All (Regex.regex "\\s")
        |> List.map String.toInt
        |> List.map Result.toMaybe
        |> List.filterMap identity


parseInput : String -> List (List Int)
parseInput x =
    x
        |> String.trim
        |> String.split "\n"
        |> List.map parseRow


solution : List (List Int) -> Int
solution input =
    let
        row : List Int -> Int
        row x =
            case x of
                [] ->
                    0

                [ x ] ->
                    0

                _ ->
                    Maybe.map2 (-) (List.maximum x) (List.minimum x)
                        |> Maybe.withDefault 0
    in
        input
            |> List.map row
            |> List.foldl (+) 0


solution2 : List (List Int) -> Int
solution2 input =
    let
        evenDivision : Int -> Int -> Int
        evenDivision x y =
            if x % y == 0 then
                x // y
            else if y % x == 0 then
                y // x
            else
                0

        solve : List Int -> Int
        solve i =
            case i of
                [] ->
                    0

                [ x ] ->
                    0

                x :: xs ->
                    let
                        solution =
                            xs
                                |> List.map (evenDivision x)
                                |> List.foldl (+) 0
                    in
                        if (solution > 0) then
                            solution
                        else
                            solve xs
    in
        input
            |> List.map solve
            |> List.foldl (+) 0

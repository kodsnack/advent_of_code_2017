module Day3 exposing (..)

import Dict exposing (Dict)


parseInput : String -> Int
parseInput x =
    x
        |> String.toInt
        |> Result.toMaybe
        |> Maybe.withDefault 0


part1 : String -> Int
part1 input =
    if (parseInput input) > 1 then
        solution1 ( 0, 0 ) ( 1, 0 ) 1 (parseInput input) Dict.empty
    else
        (parseInput input)


part2 : String -> Int
part2 input =
    if (parseInput input) > 1 then
        solution2 ( 0, 0 ) ( 1, 0 ) 1 (parseInput input) Dict.empty
    else
        (parseInput input)


solution1 : ( Int, Int ) -> ( Int, Int ) -> Int -> Int -> Grid -> Int
solution1 ( x1, y1 ) ( x2, y2 ) value t grid =
    let
        ( x3, y3 ) =
            nextPos grid ( x1, y1 ) ( x2, y2 )
    in
        if value == t then
            abs x1 + abs y1
        else
            solution1 ( x2, y2 ) ( x3, y3 ) (value + 1) t (Dict.insert ( x1, y1 ) value grid)


solution2 : ( Int, Int ) -> ( Int, Int ) -> Int -> Int -> Grid -> Int
solution2 ( x1, y1 ) ( x2, y2 ) v t grid =
    let
        ( x3, y3 ) =
            nextPos grid ( x1, y1 ) ( x2, y2 )

        value =
            [ [ ( -1, 1 ), ( 0, 1 ), ( 1, 1 ) ]
            , [ ( -1, 0 ), ( 0, 0 ), ( 1, 0 ) ]
            , [ ( -1, -1 ), ( 0, -1 ), ( 1, -1 ) ]
            ]
                |> List.concat
                |> List.map (\( x, y ) -> valueAtPosition grid ( x1 + x, y1 + y ))
                |> List.foldl (+) 0
    in
        if value > t then
            value
        else
            solution2 ( x2, y2 ) ( x3, y3 ) (v + 1) t (Dict.insert ( x1, y1 ) value grid)



--


type alias Grid =
    Dict ( Int, Int ) Int


valueAtPosition : Grid -> ( Int, Int ) -> Int
valueAtPosition grid ( x, y ) =
    case Dict.get ( x, y ) grid of
        Just x ->
            x

        Nothing ->
            if ( x, y ) == ( 0, 0 ) then
                1
            else
                0


nextPos : Grid -> ( Int, Int ) -> ( Int, Int ) -> ( Int, Int )
nextPos grid ( x1, y1 ) ( x2, y2 ) =
    let
        ( vx, vy ) =
            ( x2 - x1, y2 - y1 )
    in
        if Dict.get ( x2 - vy, y2 + vx ) grid |> isJust then
            ( x2 + vx, y2 + vy )
        else
            ( x2 - vy, y2 + vx )


isJust : Maybe a -> Bool
isJust m =
    case m of
        Nothing ->
            False

        Just _ ->
            True

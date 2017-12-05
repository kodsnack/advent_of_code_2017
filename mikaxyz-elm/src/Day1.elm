module Day1 exposing (..)


part1 input =
    day1 (parseInput input) 1


part2 input =
    day1 (parseInput input) (List.length (parseInput input) // 2)


parseInput : String -> List Int
parseInput x =
    x
        |> String.split ""
        |> List.map String.toInt
        |> List.map Result.toMaybe
        |> List.filterMap identity


day1 : List Int -> Int -> Int
day1 input offset =
    let
        roll : List a -> List a
        roll x =
            case x of
                [] ->
                    []

                [ x ] ->
                    [ x ]

                x :: xs ->
                    xs ++ [ x ]

        rollN : Int -> List a -> List a
        rollN n x =
            if n > 0 then
                rollN (n - 1) (roll x)
            else
                x

        captcha : Int -> List Int -> Int
        captcha x input =
            let
                compare =
                    rollN x input
            in
                input
                    |> List.map2
                        (\x y ->
                            if x == y then
                                x
                            else
                                0
                        )
                        compare
                    |> List.foldl (+) 0
    in
        captcha offset input

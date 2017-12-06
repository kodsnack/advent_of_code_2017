module Day4 exposing (..)

import Regex
import Dict


parseInput : String -> List (List String)
parseInput x =
    x
        |> String.trim
        |> String.lines
        |> List.map (\x -> x |> String.trim |> String.words)


part1 : String -> Int
part1 input =
    (parseInput input)
        |> List.filter hasUniqueParts
        |> List.length


part2 : String -> Int
part2 input =
    (parseInput input)
        |> List.filter hasUniqueParts
        |> List.map (\x -> List.map sortedString x)
        |> List.filter hasUniqueParts
        |> List.length


hasUniqueParts : List String -> Bool
hasUniqueParts passphrase =
    let
        unique =
            passphrase
                |> List.foldl
                    (\x a ->
                        if List.member x a then
                            a
                        else
                            x :: a
                    )
                    []

        --                |> Debug.log "lllll"
        --                |> List.length
    in
        List.length passphrase == List.length unique


sortedString : String -> String
sortedString s =
    s
        |> String.split ""
        |> List.sort
        |> String.join ""

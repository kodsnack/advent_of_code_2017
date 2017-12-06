module Main exposing (main)

import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Day1
import Day2
import Day3
import Day4
import Day5


main =
    Html.program
        { init = ( Model Day1 "", Cmd.none )
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }


type Msg
    = OnInput String
    | SetProblem String


type Problem
    = Day1
    | Day2
    | Day3
    | Day4
    | Day5


type alias Model =
    { problem : Problem
    , input : String
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnInput x ->
            ( { model | input = x }, Cmd.none )

        SetProblem x ->
            ( { model | problem = problemFromString x }, Cmd.none )


problems : List ( String, Problem )
problems =
    [ ( toString Day1, Day1 )
    , ( toString Day2, Day2 )
    , ( toString Day3, Day3 )
    , ( toString Day4, Day4 )
    , ( toString Day5, Day5 )
    ]


problemFromString : String -> Problem
problemFromString x =
    problems
        |> List.filter (\y -> Tuple.first y == x)
        |> List.map Tuple.second
        |> List.head
        |> Maybe.withDefault Day1


view : Model -> Html Msg
view model =
    div [ style [ ( "font-family", "monospace" ) ] ]
        [ h1 [] [ text "AoC 2017", small [ style [] ] [ a [ href "https://twitter.com/mikajauhonen" ] [ small [] [ text "@mikajauhonen" ] ] ] ]
        , div []
            [ p []
                [ Html.textarea [ onInput OnInput, style [ ( "width", "100%" ), ( "height", "8em" ), ( "box-sizing", "border-box" ), ( "padding", "1em" ) ] ] [] ]
            , p []
                [ select [ onInput SetProblem ] <| List.map (\x -> option [ selected (model.problem == x), value <| toString x ] [ text <| toString x ]) (List.map Tuple.second problems) ]
            ]
        , case model.problem of
            Day1 ->
                dl []
                    [ dt [] [ text "Day 1, part 1" ]
                    , dd []
                        [ Day1.part1 model.input
                            |> toString
                            |> text
                        ]
                    , dt [] [ text "Day 1, part 2" ]
                    , dd []
                        [ Day1.part2 model.input
                            |> toString
                            |> text
                        ]
                    ]

            Day2 ->
                dl []
                    [ dt [] [ text "Day 2, part 1" ]
                    , dd []
                        [ Day2.part1 model.input
                            |> toString
                            |> text
                        ]
                    , dt [] [ text "Day 2, part 2" ]
                    , dd []
                        [ Day2.part2 model.input
                            |> toString
                            |> text
                        ]
                    ]

            Day3 ->
                dl []
                    [ dt [] [ text "Day 3, part 1" ]
                    , dd []
                        [ Day3.part1 model.input
                            |> toString
                            |> text
                        ]
                    , dt [] [ text "Day 3, part 2" ]
                    , dd []
                        [ Day3.part2 model.input
                            |> toString
                            |> text
                        ]
                    ]

            Day4 ->
                dl []
                    [ dt [] [ text "Day 4, part 1" ]
                    , dd []
                        [ Day4.part1 model.input
                            |> toString
                            |> text
                        ]
                    , dt [] [ text "Day 4, part 2" ]
                    , dd []
                        [ Day4.part2 model.input
                            |> toString
                            |> text
                        ]
                    ]

            Day5 ->
                dl []
                    [ dt [] [ text "Day 5, part 1" ]
                    , dd []
                        [ Day5.part1 model.input
                            |> toString
                            |> text
                        ]
                    , dt [] [ text "Day 5, part 2" ]
                    , dd []
                        [ Day5.part2 model.input
                            |> toString
                            |> text
                        ]
                    ]
        ]

module View exposing (view)

import Types exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Html exposing (Html, div, h1)
import Html.Attributes


gridSize : Int
gridSize =
    50


boardSize : Int
boardSize =
    gridSize * 10


view : Model -> Html msg
view model =
    div
        [ Html.Attributes.style [ ( "text-align", "center" ) ] ]
        [ h1 []
            [ text "Langton's Ant" ]
        , svg
            [ width <| toString boardSize
            , height <| toString boardSize
            ]
            (List.map filledSquare model.board
                ++ [ ant model.position model.direction
                   , boundingBox
                   ]
            )
        ]


filledSquare : Position -> Svg msg
filledSquare ( xPos, yPos ) =
    rect
        [ width <| toString gridSize
        , height <| toString gridSize
        , x <| toString <| xPos * gridSize
        , y <| toString <| yPos * gridSize
        , fill "black"
        ]
        []


ant : Position -> Direction -> Svg msg
ant ( xPos, yPos ) dir =
    let
        ( radiusX, radiusY ) =
            case dir of
                Up ->
                    ( gridSize // 5, gridSize * 4 // 10 )

                Down ->
                    ( gridSize // 5, gridSize * 4 // 10 )

                Left ->
                    ( gridSize * 4 // 10, gridSize // 5 )

                Right ->
                    ( gridSize * 4 // 10, gridSize // 5 )
    in
        ellipse
            [ rx <| toString <| radiusX
            , ry <| toString <| radiusY
            , cx <| toString <| xPos * gridSize + gridSize // 2
            , cy <| toString <| yPos * gridSize + gridSize // 2
            , fill "red"
            ]
            []


boundingBox : Svg msg
boundingBox =
    rect
        [ x "0"
        , y "0"
        , width <| toString boardSize
        , height <| toString boardSize
        , fill "none"
        , stroke "black"
        ]
        []

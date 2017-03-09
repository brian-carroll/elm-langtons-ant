module View exposing (view)

import Types exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)


gridSize : Int
gridSize =
    50


boardSize : Int
boardSize =
    gridSize * 10


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


view : Model -> Svg msg
view model =
    svg
        [ width <| toString boardSize
        , height <| toString boardSize
        ]
        (List.map filledSquare model.board
            ++ [ ant model.position, boundingBox ]
        )


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


ant : Position -> Svg msg
ant ( xPos, yPos ) =
    ellipse
        [ rx <| toString <| gridSize//4
        , ry <| toString <| gridSize//4
        , cx <| toString <| xPos * gridSize + gridSize//2
        , cy <| toString <| yPos * gridSize + gridSize//2
        , fill "red"
        ]
        []

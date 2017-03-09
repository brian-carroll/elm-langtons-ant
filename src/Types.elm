module Types exposing (..)

import Time


type alias Position =
    ( Int, Int )


type alias Board =
    List Position


type Square
    = Black
    | White


type Direction
    = Up
    | Down
    | Left
    | Right


type alias Model =
    { board : Board
    , position : Position
    , direction : Direction
    }


type Msg
    = Tick Time.Time

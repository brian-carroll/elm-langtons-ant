module Types exposing (..)

import Time


type alias Position =
    ( Int, Int )


-- List of black squares to draw (just don't draw the white ones)
type alias Board =
    List Position


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

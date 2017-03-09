module State exposing (..)

import Types exposing (..)
import Time exposing (millisecond)


goRight : Model -> Model
goRight model =
    { model
        | direction = Right
        , position =
            ( (Tuple.first model.position + 1) % 10
            , Tuple.second model.position
            )
    }


goLeft : Model -> Model
goLeft model =
    { model
        | direction = Left
        , position =
            ( (Tuple.first model.position - 1) % 10
            , Tuple.second model.position
            )
    }


goUp : Model -> Model
goUp model =
    { model
        | direction = Up
        , position =
            ( Tuple.first model.position
            , (Tuple.second model.position + 1) % 10
            )
    }


goDown : Model -> Model
goDown model =
    { model
        | direction = Down
        , position =
            ( Tuple.first model.position
            , (Tuple.second model.position - 1) % 10
            )
    }


turnRight : Model -> Model
turnRight model =
    case model.direction of
        Up ->
            goRight model

        Down ->
            goLeft model

        Left ->
            goUp model

        Right ->
            goDown model


turnLeft : Model -> Model
turnLeft model =
    case model.direction of
        Up ->
            goLeft model

        Down ->
            goRight model

        Left ->
            goDown model

        Right ->
            goUp model


isBlackSquare : Model -> Bool
isBlackSquare model =
    List.member model.position model.board


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Tick _ ->
            ( if isBlackSquare model then
                let
                    turnedModel =
                        turnLeft model
                in
                    { turnedModel
                        | board = List.filter ((/=) model.position) model.board
                    }
              else
                let
                    turnedModel =
                        turnRight model
                in
                    { turnedModel
                        | board = model.position :: model.board
                    }
            , Cmd.none
            )


init : ( Model, Cmd msg )
init =
    ( { board = [ ( 5, 5 ), ( 8, 8 ) ]
      , position = ( 3, 3 )
      , direction = Down
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Time.every (100 * millisecond) Tick

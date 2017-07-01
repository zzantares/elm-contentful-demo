module Main exposing (..)

import Debug exposing (log)
import Html exposing (..)
import Material
import Messages exposing (..)
import Models exposing (..)
import View exposing (..)


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HandleEntriesResponse result ->
            case result of
                Ok newEntries ->
                    ( { model | entries = newEntries }, Cmd.none )

                Err err ->
                    let
                        _ =
                            Debug.log "We got problemo!" err
                    in
                        ( model, Cmd.none )

        ApiResponded (Ok newContents) ->
            ( { model | contents = (Debug.log "Api dice" newContents) }, Cmd.none )

        ApiResponded (Err error) ->
            let
                _ =
                    Debug.log "Error es: " error
            in
                ( model, Cmd.none )

        SelectTab num ->
            { model | selectedTab = num } ! []

        Mdl msg_ ->
            Material.update Mdl msg_ model


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

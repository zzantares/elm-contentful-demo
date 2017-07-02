module Main exposing (..)

import Contentful
import Debug exposing (log)
import Html exposing (..)
import Material
import Material.Snackbar as Snackbar
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

        HandlePublishedEntryResponse result ->
            case result of
                Ok _ ->
                    ( { model | selectedTab = 0 }, Cmd.none )

                Err err ->
                    let
                        _ =
                            Debug.log "We got problemo upon entry publishment!" err
                    in
                        ( model, Cmd.none )

        HandleNewEntryResponse result ->
            case result of
                Ok newEntryId ->
                    ( { model | newPostTitle = "", newPostBody = "" }
                    , publishContentful newEntryId
                    )

                Err err ->
                    let
                        _ =
                            Debug.log "We got problemo upon entry creation!" err
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

        SetPostTitle title ->
            { model | newPostTitle = title } ! []

        SetPostBody body ->
            { model | newPostBody = body } ! []

        CreateNewPost ->
            if
                String.isEmpty (String.trim model.newPostTitle)
                    || String.isEmpty (String.trim model.newPostBody)
            then
                ( model, Cmd.none )
            else
                ( model
                , postContentful
                    (Contentful.Entry
                        model.newPostTitle
                        model.newPostBody
                    )
                )

        GoHome ->
            { model | selectedTab = 0, newPostTitle = "", newPostBody = "" } ! []

        SelectTab num ->
            { model | selectedTab = num } ! []

        Mdl msg_ ->
            Material.update Mdl msg_ model


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

module Main exposing (..)

import Auth
import Contentful
import Debug exposing (log)
import Html exposing (..)
import Http
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (decode, required)


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias Model =
    { contents : String
    , entries : List Contentful.Entry
    }


init : ( Model, Cmd Msg )
init =
    ( Model "" []
    , getContentful
    )


type Msg
    = ApiResponded (Result Http.Error String)
    | HandleEntriesResponse (Result Http.Error (List Contentful.Entry))


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


view : Model -> Html Msg
view model =
    div []
        [ span [] [ text model.contents ]
        , br [] []
        , div [] (List.map viewEntry model.entries)
        ]


viewEntry : Contentful.Entry -> Html Msg
viewEntry entry =
    div []
        [ h2 [] [ text entry.title ]
        , article [] [ text entry.body ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- Get initial contentful entries (blog posts)


getContentful : Cmd Msg
getContentful =
    Http.send HandleEntriesResponse Contentful.getEntriesRequest

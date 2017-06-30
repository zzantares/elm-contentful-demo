module Main exposing (..)

import Auth
import Contentful
import Debug exposing (log)
import Html exposing (..)
import Html.Attributes exposing (style)
import Http
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (decode, required)
import Material
import Material.Color as Color
import Material.Elevation as Elevation
import Material.Grid exposing (..)
import Material.Layout as Layout
import Material.Options as Options exposing (css)
import Material.Scheme


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
    , mdl : Material.Model
    , selectedTab : Int
    }


model : Model
model =
    { contents = ""
    , entries = []
    , mdl = Material.model
    , selectedTab = 0
    }


init : ( Model, Cmd Msg )
init =
    ( model, getContentful )


type Msg
    = ApiResponded (Result Http.Error String)
    | HandleEntriesResponse (Result Http.Error (List Contentful.Entry))
    | SelectTab Int
    | Mdl (Material.Msg Msg)


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


view : Model -> Html Msg
view model =
    Material.Scheme.topWithScheme Color.Blue Color.DeepOrange <|
        Layout.render Mdl
            model.mdl
            [ Layout.fixedHeader
            , Layout.onSelectTab SelectTab
            ]
            { header =
                [ h2 [ style [ ( "padding", "2rem" ) ] ]
                    [ text "Elm, Contentful & Fun with Decoders" ]
                ]
            , drawer = []
            , tabs = ( [ text "Home", text "New Entry" ], [] )
            , main =
                [ grid []
                    [ cell [ size All 6, offset All 3 ] [ viewBody model ]
                    ]
                ]
            }


viewBody : Model -> Html Msg
viewBody model =
    case model.selectedTab of
        0 ->
            viewHome model

        1 ->
            viewAdminArea model

        _ ->
            h1 [] [ text "404 Not Found" ]


viewHome : Model -> Html msg
viewHome model =
    div []
        [ span [] [ text model.contents ]
        , br [] []
        , div [] (List.map viewEntry model.entries)
        ]


viewEntry : Contentful.Entry -> Html msg
viewEntry entry =
    Options.div
        [ Elevation.e6
        , css "margin-bottom" "20px"
        , css "padding" "20px"
        ]
        [ h3 [] [ text entry.title ]
        , article [] [ text entry.body ]
        ]


viewAdminArea : Model -> Html Msg
viewAdminArea model =
    div []
        [ text "Insert a form here dude!" ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- Get initial contentful entries (blog posts)


getContentful : Cmd Msg
getContentful =
    Http.send HandleEntriesResponse Contentful.getEntriesRequest

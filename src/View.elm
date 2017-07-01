module View exposing (..)

import Contentful
import Html exposing (..)
import Html.Attributes exposing (style)
import Material
import Material.Color as Color
import Material.Elevation as Elevation
import Material.Grid exposing (..)
import Material.Layout as Layout
import Material.Options as Options exposing (css)
import Material.Scheme
import Messages exposing (..)
import Models exposing (..)


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

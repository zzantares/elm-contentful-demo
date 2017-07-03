module View exposing (..)

import Auth
import Contentful
import Html exposing (..)
import Html.Attributes exposing (style, required, href, value, defaultValue)
import Html.Events exposing (onInput)
import Material
import Material.Button as Button
import Material.Color as Color
import Material.Elevation as Elevation
import Material.Grid exposing (..)
import Material.Layout as Layout
import Material.List as Lists
import Material.Options as Options exposing (css)
import Material.Scheme
import Material.Textfield as Textfield
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
            , drawer = viewDrawer model
            , tabs = ( [ text "Home", text "New Entry" ], [] )
            , main =
                [ grid []
                    [ cell [ size All 6, offset All 3 ] [ viewBody model ]
                    ]
                ]
            }


viewDrawer : Model -> List (Html Msg)
viewDrawer model =
    [ Layout.title [] [ text "Links" ]
    , Layout.navigation []
        [ Lists.content []
            [ Layout.link
                [ Layout.href "#" ]
                [ Lists.icon "code" [], text " GitHub" ]
            , Layout.link
                [ Layout.href "#" ]
                [ Lists.icon "subscriptions" [], text " Screencast" ]
            ]
        ]
    ]


viewBody : Model -> Html Msg
viewBody model =
    case model.selectedTab of
        0 ->
            viewHome model

        1 ->
            viewAdminArea model

        _ ->
            h1 [] [ text "404 Not Found" ]


viewHome : Model -> Html Msg
viewHome model =
    div []
        [ span [] [ text model.contents ]
        , br [] []
        , div [] (List.indexedMap viewEntry model.entries)
        ]


viewEntry : Int -> Contentful.Entry -> Html Msg
viewEntry idx entry =
    Options.div
        [ Elevation.e6
        , css "margin-bottom" "20px"
        , css "padding" "20px"
        ]
        [ h3 [] [ text entry.title ]
        , article [] [ text entry.body ]
        , hr [] []
        , Button.render Mdl
            [ 0 ]
            model.mdl
            [ Button.colored

            -- , Options.onClick (ReadEntry idx)
            ]
            [ text "Read more" ]
        ]


viewAdminArea : Model -> Html Msg
viewAdminArea model =
    Options.div
        [ Elevation.e6
        , css "margin-bottom" "20px"
        , css "padding" "20px"

        -- center this form
        ]
        [ h3 [] [ text "New entry" ]
        , div []
            [ div [ style [ ( "text-align", "center" ) ] ]
                [ select
                    [ onInput SetAuthorId
                    , defaultValue
                        Auth.defaultAuthorId
                    ]
                    (List.map (\a -> option [ value a.id ] [ text a.name ]) model.authors)
                , div [] [ inputPostTitle model ]
                , div [] [ inputPostBody model ]
                , Button.render Mdl
                    [ 0 ]
                    model.mdl
                    [ Button.raised
                    , Button.colored
                    , Button.ripple
                    , Options.onClick CreateNewPost
                    ]
                    [ text "Publish new Entry" ]
                , Button.render Mdl
                    [ 0 ]
                    model.mdl
                    [ Options.onClick GoHome
                    , Button.accent
                    , Options.css "margin-left" "10px"
                    ]
                    [ text "Cancel" ]
                ]
            ]
        ]


inputPostTitle : Model -> Html Msg
inputPostTitle model =
    Textfield.render Mdl
        [ 2 ]
        model.mdl
        [ Textfield.label "Post title"
        , Textfield.floatingLabel
        , Textfield.text_
        , Options.onInput SetPostTitle
        , Options.attribute (required True)
        ]
        []


inputPostBody : Model -> Html Msg
inputPostBody model =
    Textfield.render Mdl
        [ 9 ]
        model.mdl
        [ Textfield.label "Post contents"
        , Textfield.floatingLabel
        , Textfield.textarea
        , Textfield.rows 6
        , Options.onInput SetPostBody
        , Options.attribute (required True)
        ]
        []

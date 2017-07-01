module Models exposing (..)

import Contentful
import Http
import Material
import Messages exposing (..)


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



-- Get initial contentful entries (blog posts)
-- TODO: Move to Contentful.elm module?


getContentful : Cmd Msg
getContentful =
    Http.send HandleEntriesResponse Contentful.getEntriesRequest

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
    , newPostBody : String
    , newPostTitle : String
    }


model : Model
model =
    { contents = ""
    , entries = []
    , mdl = Material.model
    , selectedTab = 0
    , newPostTitle = ""
    , newPostBody = ""
    }


init : ( Model, Cmd Msg )
init =
    ( model, getContentful )



-- Get initial contentful entries (blog posts)


getContentful : Cmd Msg
getContentful =
    Http.send HandleEntriesResponse Contentful.getEntriesRequest


postContentful : Contentful.Entry -> Cmd Msg
postContentful entry =
    Http.send HandleNewEntryResponse (Contentful.postEntryRequest entry)


publishContentful : String -> Cmd Msg
publishContentful entryId =
    Http.send HandlePublishedEntryResponse (Contentful.putEntryRequest entryId)

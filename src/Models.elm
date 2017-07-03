module Models exposing (..)

import Contentful
import Http
import Material
import Messages exposing (..)


type alias Model =
    { contents : String
    , entries : List Contentful.Entry
    , mdl : Material.Model
    , authors : List Contentful.Author
    , selectedTab : Int
    , newPostBody : String
    , newPostTitle : String
    , newPostAuthor : String
    }


model : Model
model =
    { contents = ""
    , entries = []
    , mdl = Material.model
    , authors = []
    , selectedTab = 0
    , newPostTitle = ""
    , newPostBody = ""
    , newPostAuthor = ""
    }


init : ( Model, Cmd Msg )
init =
    ( model, Cmd.batch [ getContentful, getAuthors ] )



-- Get initial contentful entries (blog posts)


getContentful : Cmd Msg
getContentful =
    Http.send HandleEntriesResponse Contentful.getEntriesRequest


getAuthors : Cmd Msg
getAuthors =
    Http.send HandleAuthorsResponse Contentful.getAuthorsRequest


postContentful : Contentful.Entry -> Cmd Msg
postContentful entry =
    Http.send HandleNewEntryResponse (Contentful.postEntryRequest entry)


publishContentful : String -> Cmd Msg
publishContentful entryId =
    Http.send HandlePublishedEntryResponse (Contentful.putEntryRequest entryId)

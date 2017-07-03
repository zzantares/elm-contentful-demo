module Messages exposing (..)

import Contentful
import Http
import Material


type Msg
    = ApiResponded (Result Http.Error String)
    | HandleEntriesResponse (Result Http.Error (List Contentful.Entry))
    | HandleNewEntryResponse (Result Http.Error String)
    | HandlePublishedEntryResponse (Result Http.Error String)
    | HandleAuthorsResponse (Result Http.Error (List Contentful.Author))
    | SelectTab Int
    | SetPostTitle String
    | SetPostBody String
    | SetAuthorId String
    | CreateNewPost
    | GoHome
    | Mdl (Material.Msg Msg)

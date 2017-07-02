module Messages exposing (..)

import Contentful
import Http
import Material


type Msg
    = ApiResponded (Result Http.Error String)
    | HandleEntriesResponse (Result Http.Error (List Contentful.Entry))
    | HandleNewEntryResponse (Result Http.Error String)
    | HandlePublishedEntryResponse (Result Http.Error String)
    | SelectTab Int
    | SetPostTitle String
    | SetPostBody String
    | CreateNewPost
    | Mdl (Material.Msg Msg)

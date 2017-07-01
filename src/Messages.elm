module Messages exposing (..)

import Contentful
import Http
import Material


type Msg
    = ApiResponded (Result Http.Error String)
    | HandleEntriesResponse (Result Http.Error (List Contentful.Entry))
    | SelectTab Int
    | Mdl (Material.Msg Msg)

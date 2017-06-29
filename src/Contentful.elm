module Contentful exposing (..)

import Auth
import Date
import Http
import Json.Decode as Json
import Json.Decode.Extra exposing (..)
import Json.Decode.Pipeline exposing (decode, required, optional)


type alias Entry =
    { title : String

    -- , author : String
    -- , publishedAt : Date.Date
    , body : String
    }


type alias Space =
    { id : String
    , name : String
    }


spaceDecoder : Json.Decoder Space
spaceDecoder =
    decode Space
        |> required "sys" (Json.field "id" Json.string)
        |> required "name" Json.string


{-| Defines the Contentful API endpoint
-}
endpoint : String
endpoint =
    "https://cdn.contentful.com/"


{-| Generate a custom `GET` request to obtain the "/space/:spaceId" resource.
-}
getSpaceRequest : Http.Request Space
getSpaceRequest =
    Http.request
        { method = "GET"
        , headers = [ Http.header "Authorization" ("Bearer " ++ Auth.accessToken) ]
        , url = endpoint ++ "/spaces/" ++ Auth.spaceId
        , body = Http.emptyBody
        , expect = Http.expectJson spaceDecoder
        , timeout = Nothing
        , withCredentials = False
        }


{-| Generate a custom `GET` request to obtain the "/space/:spaceId/entries" resource.
-}
getEntriesRequest : Http.Request (List Entry)
getEntriesRequest =
    Http.request
        { method = "GET"
        , headers = [ Http.header "Authorization" ("Bearer " ++ Auth.accessToken) ]
        , url =
            endpoint
                ++ "/spaces/"
                ++ Auth.spaceId
                ++ "/entries"
                ++ "?content_type="
                ++ Auth.postContentTypeId
        , body = Http.emptyBody
        , expect = Http.expectJson entriesDecoder
        , timeout = Nothing
        , withCredentials = False
        }


entriesDecoder : Json.Decoder (List Entry)
entriesDecoder =
    Json.at [ "items" ] (Json.list entryDecoder)


entryDecoder : Json.Decoder Entry
entryDecoder =
    decode Entry
        |> required "fields" (Json.field "title" Json.string)
        |> required "fields" (Json.field "body" Json.string)

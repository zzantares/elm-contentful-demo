module Contentful exposing (..)

import Auth
import Date
import Http
import Json.Decode as Json
import Json.Decode.Extra exposing (..)
import Json.Decode.Pipeline exposing (decode, required, optional)
import Json.Encode as Encode


type alias Entry =
    { title : String

    -- , publishedAt : Date.Date
    , body : String
    , author : String
    }


type alias Space =
    { id : String
    , name : String
    }


type alias Author =
    { id : String
    , name : String
    }


spaceDecoder : Json.Decoder Space
spaceDecoder =
    decode Space
        |> required "sys" (Json.field "id" Json.string)
        |> required "name" Json.string


{-| Defines the Contentful Content Delivery API endpoint
-}
endpointCDA : String
endpointCDA =
    "https://cdn.contentful.com/"


{-| Defines the Contentful Content Management API endpoint
-}
endpointCMA : String
endpointCMA =
    "https://api.contentful.com/"


{-| Generate a custom `GET` request to obtain the "/space/:spaceId" resource.
-}
getSpaceRequest : Http.Request Space
getSpaceRequest =
    Http.request
        { method = "GET"
        , headers = [ Http.header "Authorization" ("Bearer " ++ Auth.accessToken) ]
        , url = endpointCDA ++ "/spaces/" ++ Auth.spaceId
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
            endpointCDA
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


getAuthorsRequest : Http.Request (List Author)
getAuthorsRequest =
    Http.request
        { method = "GET"
        , headers = [ Http.header "Authorization" ("Bearer " ++ Auth.personalToken) ]
        , url =
            endpointCMA
                ++ "/spaces/"
                ++ Auth.spaceId
                ++ "/entries"
                ++ "?content_type="
                ++ Auth.authorContentTypeId
        , body = Http.emptyBody
        , expect = Http.expectJson authorsDecoder
        , timeout = Nothing
        , withCredentials = False
        }


authorsDecoder : Json.Decoder (List Author)
authorsDecoder =
    Json.at [ "items" ] (Json.list authorDecoder)


authorDecoder : Json.Decoder Author
authorDecoder =
    decode Author
        |> required "sys" (Json.field "id" Json.string)
        |> required "fields" (Json.at [ "name", "en-US" ] Json.string)


entriesDecoder : Json.Decoder (List Entry)
entriesDecoder =
    Json.at [ "items" ] (Json.list entryDecoder)


entryDecoder : Json.Decoder Entry
entryDecoder =
    decode Entry
        |> required "fields" (Json.field "title" Json.string)
        |> required "fields" (Json.field "body" Json.string)
        |> required "fields"
            (Json.at [ "author" ]
                (Json.index 0
                    (Json.at
                        [ "sys"
                        , "id"
                        ]
                        Json.string
                    )
                )
            )


putEntryRequest : String -> Http.Request String
putEntryRequest entryId =
    Http.request
        { method = "PUT"
        , headers =
            [ Http.header "Authorization" ("Bearer " ++ Auth.personalToken)
            , Http.header "X-Contentful-Version" "1"
            ]
        , url =
            endpointCMA
                ++ "/spaces/"
                ++ Auth.spaceId
                ++ "/entries/"
                ++ entryId
                ++ "/published"
        , body = Http.emptyBody
        , expect = Http.expectString
        , timeout = Nothing
        , withCredentials = False
        }


postEntryRequest : Entry -> Http.Request String
postEntryRequest entry =
    Http.request
        { method = "POST"
        , headers =
            [ Http.header "Authorization"
                ("Bearer "
                    ++ Auth.personalToken
                )
            , Http.header "X-Contentful-Content-Type" Auth.postContentTypeId
            ]
        , url =
            endpointCMA
                ++ "/spaces/"
                ++ Auth.spaceId
                ++ "/entries"
        , body = Http.jsonBody (entryEncoder entry)
        , expect = Http.expectJson (Json.at [ "sys", "id" ] Json.string)
        , timeout = Nothing
        , withCredentials = False
        }


entryEncoder : Entry -> Encode.Value
entryEncoder entry =
    Encode.object
        [ ( "fields"
          , Encode.object
                [ ( "title"
                  , (Encode.object [ ( "en-US", Encode.string entry.title ) ])
                  )
                , ( "body"
                  , (Encode.object [ ( "en-US", Encode.string entry.body ) ])
                  )
                , ( "author", authorEncoder entry.author )
                ]
          )
        ]


authorEncoder : String -> Encode.Value
authorEncoder authorId =
    (Encode.object
        [ ( "en-US"
          , Encode.list
                [ (Encode.object
                    [ ( "sys"
                      , (Encode.object
                            [ ( "id", Encode.string authorId )
                            , ( "linkType", Encode.string "Entry" )
                            , ( "type", Encode.string "Link" )
                            ]
                        )
                      )
                    ]
                  )
                ]
          )
        ]
    )

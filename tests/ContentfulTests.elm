module ContentfulTests exposing (..)

import Contentful
import Expect
import Json.Decode
import SampleResponses as Sample
import Test exposing (..)
import Test.Runner.Html exposing (run)


main =
    run <| suite


success : Result a b -> Bool
success result =
    case result of
        Ok _ ->
            True

        Err _ ->
            False


suite : Test
suite =
    describe "Contentful decoders"
        [ test "Correctly decodes a Space" <|
            \() ->
                let
                    space =
                        Contentful.Space "71rop70dkqaj" "Documentation examples"

                    decodedSpace =
                        Sample.spaceResponse
                            |> Json.Decode.decodeString Contentful.spaceDecoder
                in
                    Expect.equal decodedSpace (Ok space)
        , test "Correctly decodes an Entry" <|
            \() ->
                let
                    entry =
                        Contentful.Entry
                            "Seven Tips From Ernest Hemingway on How to Write Fiction"
                            "This is the simplest seven tip post you'll read for elm"

                    decodedEntry =
                        Sample.entryResponse
                            |> Json.Decode.decodeString Contentful.entryDecoder
                in
                    Expect.equal decodedEntry (Ok entry)
        , test "Attempting to decode an Author entry as an Entry" <|
            \() ->
                let
                    decodedEntry =
                        Sample.authorResponse
                            |> Json.Decode.decodeString Contentful.entryDecoder
                in
                    success decodedEntry
                        |> Expect.false "Result should be ( Err _ )."
        , test "Attempting to decode a list of entries." <|
            \() ->
                let
                    entries =
                        [ Contentful.Entry
                            "Seven Tips From Ernest Hemingway on How to Write Fiction"
                            "This is the simplest seven tip post you'll read for elm"
                        , Contentful.Entry
                            "Down the Rabbit Hole"
                            "Alice was beginning to get very tired of sitting by her sister on the bank, and of having nothing to do: once or twice she had peeped into the book her sister was reading, but it had no pictures or conversations in it, 'and what is the use of a book,' thought Alice 'without pictures or conversation?'"
                        ]

                    decodedEntries =
                        Sample.entriesResponse
                            |> Json.Decode.decodeString Contentful.entriesDecoder
                in
                    Expect.equal decodedEntries (Ok entries)
        ]

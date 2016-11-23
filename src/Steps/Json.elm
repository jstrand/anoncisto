module Steps.Json exposing (..)

import Json.Encode
import Json.Decode

import Steps.Main exposing (all, fromList)
import Steps.Types exposing (Steps)

fromJsonWithString : String -> Steps String
fromJsonWithString s = fromJson s Json.Decode.string ""

fromJson : String -> Json.Decode.Decoder a -> a -> Steps a
fromJson s decoder default =
  let
    elements = Result.withDefault [] <| Json.Decode.decodeString (Json.Decode.list decoder) s
  in
    fromList default elements

toJsonWithString : Steps String -> String
toJsonWithString steps = toJson steps Json.Encode.string

toJson : Steps a -> (a -> Json.Encode.Value) -> String
toJson steps elemToJson =
  Json.Encode.encode 0 <| Json.Encode.list <| List.map elemToJson <| all steps

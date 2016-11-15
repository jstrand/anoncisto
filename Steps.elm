module Steps exposing (..)

import List
import Json.Encode
import Json.Decode
import Maybe
import Result

type alias Steps a =
  { previousSteps: List a
  , current: a
  , nextSteps: List a
  }

fromJsonWithString : String -> Steps String
fromJsonWithString s = fromJson s Json.Decode.string ""

fromJson : String -> Json.Decode.Decoder a -> a -> Steps a
fromJson s decoder default = 
  let elements = Result.withDefault [] <| Json.Decode.decodeString (Json.Decode.list decoder) s
  in
    fromList default elements

fromList : a -> List a -> Steps a
fromList default lst =
  case lst of
    x::xs -> new x xs
    _ -> new default []

toJsonWithString : Steps String -> String
toJsonWithString steps = toJson steps Json.Encode.string

toJson : Steps a -> (a -> Json.Encode.Value) -> String
toJson steps elemToJson =
  Json.Encode.encode 0 <| Json.Encode.list <| List.map elemToJson <| all steps

all : Steps a -> List a
all steps =
  let { previousSteps, current, nextSteps } = steps
  in List.reverse previousSteps ++ current :: nextSteps

new : a -> List a -> Steps a 
new step nextSteps =
  { previousSteps = []
  , current = step
  , nextSteps = nextSteps    
  }

set : Steps a -> a -> Steps a
set steps step =
  { steps | current = step }

next : Steps a -> Steps a
next steps =
  let { previousSteps, current, nextSteps } = steps
  in 
  case nextSteps of
    n::rest -> { current = n, nextSteps = rest, previousSteps = current::previousSteps }
    _ -> steps


previous : Steps a -> Steps a
previous steps =
  let { previousSteps, current, nextSteps } = steps
  in 
  case previousSteps of
    n::rest -> { current = n, nextSteps = current::nextSteps, previousSteps = rest }
    _ -> steps

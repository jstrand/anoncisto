module Presentation.Main exposing (initialModel)

import Presentation.Types exposing (Model, Mode(..), Msg(..))
import Steps.Main as Steps

initialModel : List String -> String -> (Model, Cmd Msg)
initialModel slides flipUrl =
  let firstSlide = Maybe.withDefault "Empty presentation" <| List.head slides
      rest = Maybe.withDefault [] <| List.tail slides
  in
    (Model (Steps.new firstSlide rest) Presenting flipUrl
    , Cmd.none)


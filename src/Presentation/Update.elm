module Presentation.Update exposing
  (updatePresentation)

import Http
import Json.Decode
import Task

import Presentation.Types exposing (Model, Mode(..), Msg(..))
import Steps.Json as Steps
import Steps.Main as Steps

defaultSlide : String
defaultSlide = """
# Ditt innehåll här...
* Ett
* Två
* Tre
"""

updatePresentation : Msg -> Model -> (Model, Cmd Msg)
updatePresentation msg model =
  case msg of
    Next ->
      ({ model | slides = Steps.next model.slides }, Cmd.none)
    Previous ->
      ({ model | slides = Steps.previous model.slides }, Cmd.none)
    NewMessage str -> updatePresentation Next model
    Noop ->
      (model, Cmd.none)

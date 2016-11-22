module Presentation.Update exposing
  ( backendUrl
  , slidesDecoder
  , updatePresentation)

import Http
import Json.Decode
import Task

import Presentation.Types exposing (Model, Mode(..), Msg(..))
import Steps.Json as Steps
import Steps.Main as Steps

slidesDecoder : Json.Decode.Decoder (List String)
slidesDecoder = Json.Decode.list Json.Decode.string

backendUrl : String
backendUrl = "http://localhost:5000/"

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
    Change newContent ->
      ({ model | editBuffer = newContent }, Cmd.none)
    Edit ->
      ({ model | mode = Editing, editBuffer = model.slides.current }, Cmd.none)
    Save ->
      let newSlides = Steps.set model.slides model.editBuffer in
      (
        { model |
          mode = Presenting
          , slides = newSlides
        }
        , Task.perform SaveFail SaveOk
          <| Http.post slidesDecoder backendUrl
          <| Http.string
          <| Steps.toJsonWithString newSlides
      )
    Cancel ->
      ({ model | mode = Presenting, editBuffer = "" }, Cmd.none)
    Next ->
      ({ model | slides = Steps.next model.slides }, Cmd.none)
    Previous ->
      ({ model | slides = Steps.previous model.slides }, Cmd.none)
    SaveOk body -> (model, Cmd.none)
    SaveFail error -> ({model | mode = Failed}, Cmd.none)
    LoadOk steps -> ({model | slides = Steps.fromList defaultSlide steps, mode = Presenting}, Cmd.none)
    LoadFail error -> ({model | mode = Editing, editBuffer = "Error" }, Cmd.none)
    NewMessage str -> updatePresentation Next model
    Noop ->
      (model, Cmd.none)

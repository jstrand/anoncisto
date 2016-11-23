module Presentation.View exposing (viewPresentation)

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events exposing (onClick, onInput)
import Markdown

import Presentation.Types exposing (Model, Mode(..), Msg(..))

slideStyles : List (String, String)
slideStyles =
  [ ("width", "40em")
  , ("margin", "auto")
  , ("margin-top", "4em")
  , ("font-family", "Helvetica")
  , ("font-size", "18pt")
  ]

previewStyles : List (String, String)
previewStyles =
  [ ("font-family", "Helvetica")
  , ("font-size", "12pt")
  ]

showCurrentSlide : Model -> Html a
showCurrentSlide model =
  Markdown.toHtml [Attr.style slideStyles] <| model.slides.current

viewPresentation : Model -> Html Msg
viewPresentation model =
  case model.mode of
    Presenting -> showCurrentSlide model

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

editStyles : List (String, String)
editStyles =
  [ ("width", "100%")
  , ("height", "20em")
  ] ++ previewStyles

previewStyles : List (String, String)
previewStyles =
  [ ("font-family", "Helvetica")
  , ("font-size", "12pt")
  ]

editContainerStyles : List (String, String)
editContainerStyles =
  [ ("margin", "auto")
  , ("width", "40em")
  , ("margin-top", "4em")
  ]

saveButton : Html Msg
saveButton = Html.button [onClick Save] [Html.text "Spara"]

cancelButton : Html Msg
cancelButton = Html.button [onClick Cancel] [Html.text "Avbryt"]

showCurrentSlide : Model -> Html a
showCurrentSlide model =
  Markdown.toHtml [Attr.style slideStyles] <| model.slides.current

showSlideEdit : Model -> Html Msg
showSlideEdit model =
  Html.div [Attr.style editContainerStyles]
    [ Html.textarea [Attr.style editStyles, Attr.value model.editBuffer, onInput Change] []
    , Html.div [] [saveButton, cancelButton]
    , Markdown.toHtml [Attr.style previewStyles] <| model.editBuffer
    ]

viewPresentation : Model -> Html Msg
viewPresentation model =
  case model.mode of
    Loading -> Html.text "Laddar..."
    Failed -> Html.text "Fel..."
    Editing -> showSlideEdit model
    Presenting -> showCurrentSlide model

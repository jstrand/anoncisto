module Flip.View exposing (viewFlip)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Flip.Types exposing (..)

nextStyle height = style
  [ ("width", "75%")
  , ("height", scale height)
  , ("border", "none")
  , ("background-color", "#116416")
  , ("color", "white")
  , ("font-weight", "bold")
  , ("font-size", "70pt")
  ]

scale height =
  let scaledStr = toString <| toFloat height * 0.9
  in scaledStr ++ "px"

previousStyle height = style
  [ ("width", "22%")
  , ("margin-right", "3%")
  , ("height", scale height)
  , ("border", "none")
  , ("background-color", "#550000")
  , ("color", "white")
  , ("font-weight", "bold")
  , ("font-size", "70pt")
  ]

containerStyle height = style
  [ ("margin", (toString (toFloat height*0.05)) ++ "px")
  ]

viewFlip : FlipModel -> Html FlipMsg
viewFlip model =
  div [containerStyle model.viewHeight]
    [ button [previousStyle model.viewHeight, onClick Previous] [text "<"]
    , button [nextStyle model.viewHeight, onClick Next] [text ">"]
    ]
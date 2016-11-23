module Flip.View exposing (viewFlip)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Flip.Types exposing (..)

viewFlip : FlipModel -> Html FlipMsg
viewFlip model =
  div []
    [ button [onClick Send] [text "Send"]
    ]
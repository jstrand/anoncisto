module Flip.Update exposing (updateFlip)

import WebSocket

import Flip.Types exposing (..)
import Flip.Config as Config

send str = WebSocket.send Config.flipServer str

updateFlip : FlipMsg -> FlipModel -> (FlipModel, Cmd FlipMsg)
updateFlip msg model =
  case msg of

    Next ->
      (model, send "Next")

    Previous ->
      (model, send "Previous")

    NewMessage str ->
      (model, Cmd.none)

    NewSize size -> ({ model | viewHeight = size.height }, Cmd.none)

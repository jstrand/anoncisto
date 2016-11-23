module Flip.Update exposing (updateFlip)

import WebSocket

import Flip.Types exposing (..)

updateFlip : FlipMsg -> FlipModel -> (FlipModel, Cmd FlipMsg)
updateFlip msg model =
  case msg of

    Send ->
      (model, WebSocket.send "ws://localhost:9000" "boing")

    NewMessage str ->
      (model, Cmd.none)

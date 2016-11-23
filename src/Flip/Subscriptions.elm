module Flip.Subscriptions exposing (flipSubs)

import WebSocket

import Flip.Types exposing (..)
import Flip.Config exposing (..)

flipSubs : FlipModel -> Sub FlipMsg
flipSubs model =
  WebSocket.listen flipServer NewMessage


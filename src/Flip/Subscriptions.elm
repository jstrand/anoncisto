module Flip.Subscriptions exposing (flipSubs)

import WebSocket
import Window

import Flip.Types exposing (..)
import Flip.Config exposing (..)

flipSubs : FlipModel -> Sub FlipMsg
flipSubs model =
  Sub.batch
    [ WebSocket.listen flipServer NewMessage
    , Window.resizes NewSize
    ]


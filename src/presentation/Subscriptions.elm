module Presentation.Subscriptions exposing (presentationSubscriptions)

import Keyboard
import WebSocket

import Presentation.Types exposing (Model, Mode(..), Msg(..))

keyToMsg : Int -> Msg
keyToMsg code =
  case code of
    39 -> Next
    37 -> Previous
    13 -> Edit
    _  -> Noop

broadCastEndpoint : String
broadCastEndpoint = "ws://localhost:9000"

presentationSubscriptions : Model -> Sub Msg
presentationSubscriptions model =
  case model.mode of
    Presenting -> Sub.batch
      [ Keyboard.presses keyToMsg
      , WebSocket.listen broadCastEndpoint NewMessage
      ]
    Editing -> Sub.none
    Loading -> Sub.none
    Failed -> Sub.none

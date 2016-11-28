module Presentation.Subscriptions exposing (presentationSubscriptions)

import Keyboard
import WebSocket

import Presentation.Types exposing (Model, Mode(..), Msg(..))

keyToMsg : Int -> Msg
keyToMsg code =
  case code of
    39 -> Next
    37 -> Previous
    _  -> Noop

presentationSubscriptions : Model -> Sub Msg
presentationSubscriptions model =
  case model.mode of
    Presenting -> Sub.batch
      [ Keyboard.downs keyToMsg
      , WebSocket.listen model.flipUrl NewMessage
      ]

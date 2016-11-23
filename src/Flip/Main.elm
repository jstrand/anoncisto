module Flip.Main exposing (main)

import Html.App as App

import Flip.Subscriptions exposing (flipSubs)
import Flip.Update exposing (updateFlip)
import Flip.View exposing (viewFlip)
import Flip.Types exposing (..)

initFlip : (FlipModel, Cmd FlipMsg)
initFlip =
  ((), Cmd.none)

main : Program Never
main =
  App.program
    { init = initFlip
    , view = viewFlip
    , update = updateFlip
    , subscriptions = flipSubs
    }

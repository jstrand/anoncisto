module Flip.Main exposing (main)

import Html.App as App
import Window
import Task

import Flip.Subscriptions exposing (flipSubs)
import Flip.Update exposing (updateFlip)
import Flip.View exposing (viewFlip)
import Flip.Types exposing (..)

initFlip : (FlipModel, Cmd FlipMsg)
initFlip =
  (FlipModel 0, Task.perform NewSize NewSize Window.size)

main : Program Never
main =
  App.program
    { init = initFlip
    , view = viewFlip
    , update = updateFlip
    , subscriptions = flipSubs
    }

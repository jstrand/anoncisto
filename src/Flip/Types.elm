module Flip.Types exposing (..)

import Window exposing (Size)

type alias FlipModel =
  {
    viewHeight: Int
  }

type FlipMsg =
    Next
  | Previous
  | NewMessage String
  | NewSize Size

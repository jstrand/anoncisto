module Presentation.Types exposing (..)

import Steps.Types exposing (Steps)

type alias Slide = String
type Mode = Presenting

type alias Model =
  { slides: Steps Slide
  , mode: Mode
  , flipUrl: String
  }

type Msg =
    Noop
  | Next
  | Previous
  | NewMessage String

module Presentation.Types exposing (..)

import Http

import Steps.Types exposing (Steps)

type alias Slide = String
type Mode = Presenting

type alias Model =
  { slides: Steps Slide
  , mode: Mode
  , editBuffer: String
  }

type Msg =
    Noop
  | Next
  | Previous
  | NewMessage String

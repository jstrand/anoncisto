module Presentation.Types exposing (..)

import Http

import Steps.Types exposing (Steps)

type alias Slide = String
type Mode = Loading | Presenting | Editing | Failed

type alias Model =
  { slides: Steps Slide
  , mode: Mode
  , editBuffer: String
  }

type Msg =
    Noop
  | Next
  | Previous
  | Edit
  | Change String
  | Save
  | Cancel
  | SaveOk (List String)
  | SaveFail Http.Error
  | LoadOk (List String)
  | LoadFail Http.Error
  | NewMessage String

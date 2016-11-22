module Steps.Types exposing (..)

type alias Steps a =
  { previousSteps: List a
  , current: a
  , nextSteps: List a
  }

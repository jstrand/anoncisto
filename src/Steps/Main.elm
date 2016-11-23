module Steps.Main exposing (..)

import Steps.Types exposing (Steps)

fromList : a -> List a -> Steps a
fromList default lst =
  case lst of
    x::xs -> new x xs
    _ -> new default []

all : Steps a -> List a
all steps =
  let { previousSteps, current, nextSteps } = steps
  in List.reverse previousSteps ++ current :: nextSteps

new : a -> List a -> Steps a
new step nextSteps =
  { previousSteps = []
  , current = step
  , nextSteps = nextSteps
  }

set : Steps a -> a -> Steps a
set steps step =
  { steps | current = step }

next : Steps a -> Steps a
next steps =
  let { previousSteps, current, nextSteps } = steps
  in
  case nextSteps of
    n::rest -> { current = n, nextSteps = rest, previousSteps = current::previousSteps }
    _ -> steps

previous : Steps a -> Steps a
previous steps =
  let { previousSteps, current, nextSteps } = steps
  in
  case previousSteps of
    n::rest -> { current = n, nextSteps = current::nextSteps, previousSteps = rest }
    _ -> steps

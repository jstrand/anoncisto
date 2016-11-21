import Html.App as App

import Presentation.Main exposing (initialModel)
import Presentation.Subscriptions exposing (presentationSubscriptions)
import Presentation.Update exposing (updatePresentation)
import Presentation.View exposing (viewPresentation)

main : Program Never
main =
  App.program
    { init = initialModel
    , view = viewPresentation
    , update = updatePresentation
    , subscriptions = presentationSubscriptions
    }

module Presentation exposing (markdownSlidesViewer)

import Html.App as App

import Presentation.Main exposing (initialModel)
import Presentation.Subscriptions exposing (presentationSubscriptions)
import Presentation.Update exposing (updatePresentation)
import Presentation.View exposing (viewPresentation)

markdownSlidesViewer : List String -> String -> Program Never
markdownSlidesViewer slides flipUrl =
  App.program
    { init = initialModel slides flipUrl
    , view = viewPresentation
    , update = updatePresentation
    , subscriptions = presentationSubscriptions
    }

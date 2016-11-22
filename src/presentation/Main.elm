module Presentation.Main exposing (initialModel)

import Http
import Task

import Presentation.Types exposing (Model, Mode(..), Msg(..))
import Presentation.Update exposing (backendUrl, slidesDecoder)
import Steps.Main as Steps

titleSlide : String
titleSlide = """

# Lunch-dragning om Elm

Johan Strand

2016-11-15

"""

introElm : String
introElm = """

# Elm
* Bla
* Bla

"""

typesInElm : String
typesInElm = """

# Types in Elm
* Bla bla
* asdf

"""

initialModel : (Model, Cmd Msg)
initialModel =
  (defaultModel
  , Task.perform LoadFail LoadOk (Http.get slidesDecoder backendUrl)
  )

defaultModel : Model
defaultModel =
  Model (Steps.new titleSlide [introElm, typesInElm]) Loading ""

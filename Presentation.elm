import Html exposing (..)
import Html.Attributes exposing (style, value)
import Html.Events exposing (onClick, onInput)
import Markdown
import Html.App as App
import Steps as Steps exposing (Steps)
import Keyboard
import Http
import Task
import Json.Decode exposing (list, string)
import WebSocket

titleSlide = """

# Lunch-dragning om Elm

Johan Strand

2016-11-15

"""

introElm = """

# Elm
* Bla
* Bla

"""

typesInElm = """

# Types in Elm
* Bla bla
* asdf

"""

type alias Slide = String
type Mode = Loading | Presenting | Editing | Failed

type alias Model =
  { slides: Steps Slide
  , mode: Mode
  , editBuffer: String
  }

slidesDecoder = Json.Decode.list Json.Decode.string

backendUrl = "http://localhost:5000/"

init =
  (defaultModel
  , Task.perform LoadFail LoadOk (Http.get slidesDecoder backendUrl)
  )

defaultModel =
  Model (Steps.new titleSlide [introElm, typesInElm]) Loading ""

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

defaultSlide = """
# Ditt innehåll här...
* Ett
* Två
* Tre
"""

decodePost = string

update msg model = 
  case msg of
    Change newContent ->
      ({ model | editBuffer = newContent }, Cmd.none)
    Edit ->
      ({ model | mode = Editing, editBuffer = model.slides.current }, Cmd.none)
    Save ->
      let newSlides = Steps.set model.slides model.editBuffer in
      (
        { model |
          mode = Presenting
          , slides = newSlides
        }
        , Task.perform SaveFail SaveOk 
          <| Http.post slidesDecoder backendUrl 
          <| Http.string
          <| Steps.toJsonWithString newSlides
      )
    Cancel ->
      ({ model | mode = Presenting, editBuffer = "" }, Cmd.none)
    Next ->
      ({ model | slides = Steps.next model.slides }, Cmd.none)
    Previous ->
      ({ model | slides = Steps.previous model.slides }, Cmd.none)
    SaveOk body -> (model, Cmd.none)
    SaveFail error -> ({model | mode = Failed}, Cmd.none)
    LoadOk steps -> ({model | slides = Steps.fromList defaultSlide steps, mode = Presenting}, Cmd.none)
    LoadFail error -> ({model | mode = Editing, editBuffer = "Error" }, Cmd.none)
    NewMessage str -> update Next model
    Noop ->
      (model, Cmd.none)

slideStyles = style 
  [ ("width", "40em")
  , ("margin", "auto")
  , ("margin-top", "4em")
  , ("font-family", "Helvetica")
  , ("font-size", "18pt")
  ]

showCurrentSlide model = Markdown.toHtml [slideStyles] <| model.slides.current

editStyles = 
  [ ("width", "100%")
  , ("height", "20em")
  ] ++ previewStyles

editContainerStyles = style
  [ ("margin", "auto")
  , ("width", "40em")
  , ("margin-top", "4em")
  ]

previewStyles =
  [ ("font-family", "Helvetica")
  , ("font-size", "12pt")
  ]

saveButton = button [onClick Save] [text "Spara"]

cancelButton = button [onClick Cancel] [text "Avbryt"]

showSlideEdit model =
  div [editContainerStyles]
    [ textarea [style editStyles, value model.editBuffer, onInput Change] []
    , div [] [saveButton, cancelButton]
    , Markdown.toHtml [style previewStyles] <| model.editBuffer
    ]

view model =
  case model.mode of
    Loading -> text "Laddar..."
    Failed -> text "Fel..."
    Editing -> showSlideEdit model
    Presenting -> showCurrentSlide model

keyToMsg code =
  case code of
    39 -> Next
    37 -> Previous
    13 -> Edit
    _  -> Noop

broadCastEndpoint = "ws://localhost:9000"

subs model = 
  case model.mode of
    Presenting -> Sub.batch [Keyboard.presses keyToMsg, WebSocket.listen broadCastEndpoint NewMessage]
    Editing -> Sub.none
    Loading -> Sub.none
    Failed -> Sub.none

main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subs
    }


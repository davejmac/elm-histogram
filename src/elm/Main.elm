import Html exposing (Html, button, div, text, input, h2, p)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Dict


main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }


-- MODEL


type alias Model =
  { newValue : String
  , frequencies : {}
  }


model : Model
model =
  { newValue = ""
  , frequencies = {}
  --, frequencies = Dict.empty
  }


-- UPDATE


type Action
    = Add
    | NewValue String


update : Action -> Model -> Model
update action model =
  case action of
    Add ->
      --{ model | frequencies = model.frequencies ++ ", " ++ model.newValue }
      { model | frequencies = model.frequencies }
    NewValue text_input ->
      { model | newValue = text_input }


-- VIEW


view : Model -> Html Action
view model =
  div []
    [ div [class "input-data"]
        [ input [ type_ "number", placeholder "Some Number", onInput NewValue ] []
        , button [ onClick Add ] [ text "Add" ]
        ]
    --, viewFrequencyDistribution model
    ]


-- viewFrequencyDistribution : Model -> Html Action
-- viewFrequencyDistribution model =
--     let
--       frequencies =
--         model.frequencies
--           |> Dict.values
--     in
--       div
--         [ class "frequency-distribution" ]
--           [ h2 [] [ text "Frequency Distribution" ]
--           , frequencies
--           ]

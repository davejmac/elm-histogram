import Html exposing (Html, button, div, text, input, h2, p)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }



-- MODEL


type alias Model =
  { valuesList : String
  , newValue : String
  }


model : Model
model =
  { valuesList = ""
  , newValue = ""
  }



-- UPDATE


type Msg
    = Add
    | NewValue String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Add ->
      { model | valuesList = model.valuesList ++ ", " ++ model.newValue }
    NewValue text_input ->
      { model | newValue = text_input }


-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ div [class "input-data"]
        [ input [ type_ "number", placeholder "Some Number", onInput NewValue ] []
        , button [ onClick Add ] [ text "Add" ]
        ]
    , div [ class "chart" ]
      [ h2 [] [ (text "Numbers") ]
      , p [] [ (text model.valuesList) ]
      ]
    ]

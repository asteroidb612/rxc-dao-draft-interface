module Frontend exposing (..)

import Browser exposing (UrlRequest)
import Browser.Dom as Dom
import Browser.Navigation as Nav
import Html
import Lamdera
import Task
import Types
import Url


type alias Model =
    Types.FrontendModel


type alias Msg =
    Types.FrontendMsg


app =
    Lamdera.frontend
        { init = init
        , onUrlRequest = \_ -> Types.FrontendNoOp
        , onUrlChange = \_ -> Types.FrontendNoOp
        , update = update
        , updateFromBackend = updateFromBackend
        , subscriptions = \_ -> Sub.none
        , view = view
        }


init : Url.Url -> Nav.Key -> ( Types.FrontendModel, Cmd Msg )
init _ key =
    ( { key = key
      , log = []
      }
    , Lamdera.sendToBackend Types.ClientInit
    )


updateFromBackend : Types.ToFrontend -> Model -> ( Model, Cmd Msg )
updateFromBackend msg model =
    case msg of
        Types.ReportErrors errors ->
            ( { model | log = errors }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Types.FrontendNoOp ->
            ( model, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = ""
    , body = List.map Html.text model.log
    }

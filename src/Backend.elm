module Backend exposing (..)

import Dict
import Env
import Http
import Json.Decode
import Lamdera exposing (ClientId, SessionId)
import Set
import Task
import Time
import Types exposing (..)
import Url



--  _____ _            _____ _
-- |_   _| |__   ___  | ____| |_ __ ___
--   | | | '_ \ / _ \ |  _| | | '_ ` _ \
--   | | | | | |  __/ | |___| | | | | | |
--   |_| |_| |_|\___| |_____|_|_| |_| |_|
--
--     _             _     _ _            _
--    / \   _ __ ___| |__ (_) |_ ___  ___| |_ _   _ _ __ ___
--   / _ \ | '__/ __| '_ \| | __/ _ \/ __| __| | | | '__/ _ \
--  / ___ \| | | (__| | | | | ||  __/ (__| |_| |_| | | |  __/
-- /_/   \_\_|  \___|_| |_|_|\__\___|\___|\__|\__,_|_|  \___|
--


type alias Model =
    BackendModel


type alias Msg =
    BackendMsg


app =
    Lamdera.backend
        { init = init
        , update = update
        , updateFromFrontend = updateFromFrontend
        , subscriptions = \_ -> Sub.none
        }


init : ( Model, Cmd Msg )
init =
    ( { log = [] }, Cmd.none )



--  _   _           _       _
-- | | | |_ __   __| | __ _| |_ ___  ___
-- | | | | '_ \ / _` |/ _` | __/ _ \/ __|
-- | |_| | |_) | (_| | (_| | ||  __/\__ \
--  \___/| .__/ \__,_|\__,_|\__\___||___/
--       |_|


update msg model =
    case msg of
        BackendNoOp ->
            ( model, Cmd.none )


updateFromFrontend sessionId clientId msg model =
    case msg of
        ClientInit ->
            ( model, Cmd.none )
                |> logging "Client initialized!"



--   ____                           _
--  / ___|___  _ ____   _____ _ __ (_) ___ _ __   ___ ___
-- | |   / _ \| '_ \ \ / / _ \ '_ \| |/ _ \ '_ \ / __/ _ \
-- | |__| (_) | | | \ V /  __/ | | | |  __/ | | | (_|  __/
--  \____\___/|_| |_|\_/ \___|_| |_|_|\___|_| |_|\___\___|
--


logging : String -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
logging log ( model, cmd ) =
    ( { model | log = log :: model.log }
    , Cmd.batch [ cmd, Lamdera.broadcast (ReportErrors (log :: model.log)) ]
    )

module Types exposing (..)

import Browser.Navigation exposing (Key)


type alias FrontendModel =
    { key : Key, log : List String }


type alias BackendModel =
    { log : List String }


type FrontendMsg
    = FrontendNoOp


type ToBackend
    = ClientInit


type BackendMsg
    = BackendNoOp


type ToFrontend
    = ReportErrors (List String)

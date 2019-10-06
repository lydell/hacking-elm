module Main exposing (main)

import Browser
import Browser.Navigation
import Html
import Url exposing (Url)


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }


type alias Model =
    { url : Url
    , key : Browser.Navigation.Key
    }


type Msg
    = UrlChanged Url
    | LinkClicked Browser.UrlRequest


init : flags -> Url -> Browser.Navigation.Key -> ( Model, Cmd msg )
init _ url key =
    ( { url = url
      , key = key
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChanged url ->
            ( { model | url = url }, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Browser.Navigation.pushUrl model.key (Url.toString url)
                    )

                Browser.External url ->
                    ( model
                    , Browser.Navigation.load url
                    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Browser.Document Msg
view _ =
    { title = "Hacking Elm"
    , body = [ Html.text "Hack hack!" ]
    }

module Main exposing (main)

import Browser
import Browser.Navigation
import Html
import Url exposing (Url)
import Url.Builder
import Url.Parser


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
    { page : Page
    , key : Browser.Navigation.Key
    }


type Msg
    = UrlChanged Url
    | LinkClicked Browser.UrlRequest


type Page
    = SlidePage Int
    | NotFound
    | Empty


init : flags -> Url -> Browser.Navigation.Key -> ( Model, Cmd msg )
init _ url key =
    let
        ( page, pageCmd ) =
            pageFromUrl key url
    in
    ( { page = page
      , key = key
      }
    , pageCmd
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChanged url ->
            let
                ( page, pageCmd ) =
                    pageFromUrl model.key url
            in
            ( { model | page = page }, pageCmd )

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
view model =
    { title = "Hacking Elm"
    , body =
        case model.page of
            SlidePage num ->
                [ Html.text ("Slide: " ++ String.fromInt num) ]

            NotFound ->
                [ Html.text "Not found!" ]

            Empty ->
                []
    }


urlParser : Url.Parser.Parser (Page -> b) b
urlParser =
    Url.Parser.oneOf
        [ Url.Parser.map Empty Url.Parser.top
        , Url.Parser.map SlidePage Url.Parser.int
        ]


pageFromUrl : Browser.Navigation.Key -> Url -> ( Page, Cmd msg )
pageFromUrl key url =
    case Url.Parser.parse urlParser url of
        Just Empty ->
            ( Empty, Browser.Navigation.replaceUrl key (slideUrl 1) )

        Just page ->
            ( page, Cmd.none )

        Nothing ->
            ( NotFound, Cmd.none )


slideUrl : Int -> String
slideUrl num =
    Url.Builder.absolute [ String.fromInt num ] []

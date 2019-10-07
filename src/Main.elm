module Main exposing (main)

import Array exposing (Array)
import Browser
import Browser.Events
import Browser.Navigation
import Html exposing (Html)
import Html.Attributes as Attr
import Json.Decode
import Slide1
import Url exposing (Url)
import Url.Builder
import Url.Parser


slides : Array (List (Html msg))
slides =
    Array.fromList
        [ Slide1.view
        ]


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
    | KeyPressed KeyPress


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

        KeyPressed key ->
            case model.page of
                SlidePage num ->
                    let
                        delta =
                            case key of
                                ArrowLeft ->
                                    -1

                                ArrowRight ->
                                    1

                        newNum =
                            clamp 1 (Array.length slides) (num + delta)
                    in
                    if newNum /= num then
                        ( model
                        , Browser.Navigation.pushUrl model.key (slideUrl newNum)
                        )

                    else
                        ( model, Cmd.none )

                _ ->
                    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Browser.Events.onKeyDown keydownDecoder


view : Model -> Browser.Document Msg
view model =
    { title = "Hacking Elm"
    , body =
        case model.page of
            SlidePage num ->
                case Array.get (num - 1) slides of
                    Just content ->
                        content

                    Nothing ->
                        [ Html.h1 [] [ Html.text ("Unknown slide: " ++ String.fromInt num) ]
                        , Html.p [] [ Html.a [ Attr.href "/" ] [ Html.text "Home" ] ]
                        ]

            NotFound ->
                [ Html.h1 [] [ Html.text "Not found!" ]
                , Html.p [] [ Html.a [ Attr.href "/" ] [ Html.text "Home" ] ]
                ]

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


type KeyPress
    = ArrowLeft
    | ArrowRight


keydownDecoder : Json.Decode.Decoder Msg
keydownDecoder =
    Json.Decode.field "key" Json.Decode.string
        |> Json.Decode.andThen
            (\key ->
                case key of
                    "ArrowLeft" ->
                        Json.Decode.succeed ArrowLeft

                    "ArrowRight" ->
                        Json.Decode.succeed ArrowRight

                    _ ->
                        Json.Decode.fail "ignored"
            )
        |> Json.Decode.map KeyPressed

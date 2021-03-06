module Main exposing (main)

import Array exposing (Array)
import Browser
import Browser.Events
import Browser.Navigation
import Html exposing (Html)
import Html.Attributes as Attr
import Json.Decode
import Slides.Conclusions
import Slides.Discourse
import Slides.HowToHack
import Slides.Intro
import Slides.Normalize
import Slides.NormalizeNaive
import Slides.NormalizeNaiveIssues
import Slides.Response
import Slides.Sort
import Slides.Thanks
import Slides.UpperCase
import Slides.UpperCaseExplained
import Url exposing (Url)
import Url.Builder
import Url.Parser


slides : Array (List (Html msg))
slides =
    Array.fromList
        [ Slides.Intro.view
        , Slides.Discourse.view
        , Slides.Response.view
        , Slides.HowToHack.view
        , Slides.UpperCase.view
        , Slides.UpperCaseExplained.view
        , Slides.NormalizeNaive.view
        , Slides.NormalizeNaiveIssues.view
        , Slides.Normalize.view
        , Slides.Sort.view
        , Slides.Conclusions.view
        , Slides.Thanks.view
        ]


getSlide : Int -> Maybe (List (Html msg))
getSlide num =
    Array.get (num - 1) slides


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
    , item : Int
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
      , item = 1
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
            ( { model | page = page, item = 1 }, pageCmd )

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
                        direction =
                            case key of
                                ArrowLeft ->
                                    Horizontal -1

                                ArrowRight ->
                                    Horizontal 1

                                ArrowUp ->
                                    Vertical -1

                                ArrowDown ->
                                    Vertical 1
                    in
                    case direction of
                        Horizontal delta ->
                            let
                                newNum =
                                    clamp 1 (Array.length slides) (num + delta)
                            in
                            if newNum /= num then
                                ( model
                                , Browser.Navigation.pushUrl model.key (slideUrl newNum)
                                )

                            else
                                ( model, Cmd.none )

                        Vertical delta ->
                            let
                                maxItem =
                                    case getSlide num of
                                        Just items ->
                                            List.length items

                                        Nothing ->
                                            1

                                newItem =
                                    clamp 1 maxItem (model.item + delta)
                            in
                            ( { model | item = newItem }, Cmd.none )

                _ ->
                    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Browser.Events.onKeyDown keydownDecoder


view : Model -> Browser.Document Msg
view model =
    let
        content =
            case model.page of
                SlidePage num ->
                    case getSlide num of
                        Just items ->
                            [ Html.div [] (List.take model.item items)
                            , viewControls
                                { slide = num
                                , maxSlide = Array.length slides
                                , item = model.item
                                , maxItem = List.length items
                                }
                            ]

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
    in
    { title = "Hacking Elm"
    , body = [ Html.div [ Attr.class "main" ] content ]
    }


type alias ViewControlsOptions =
    { slide : Int
    , maxSlide : Int
    , item : Int
    , maxItem : Int
    }


viewControls : ViewControlsOptions -> Html msg
viewControls { slide, maxSlide, item, maxItem } =
    Html.div [ Attr.class "controls" ]
        [ viewControl (item > 1)
        , viewControl (item < maxItem)
        , viewControl (slide > 1)
        , viewControl (slide < maxSlide)
        ]


viewControl : Bool -> Html msg
viewControl enabled =
    Html.div [ Attr.classList [ ( "enabled", enabled ) ] ] []


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


type Direction
    = Horizontal Int
    | Vertical Int


type KeyPress
    = ArrowLeft
    | ArrowRight
    | ArrowUp
    | ArrowDown


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

                    "ArrowUp" ->
                        Json.Decode.succeed ArrowUp

                    "ArrowDown" ->
                        Json.Decode.succeed ArrowDown

                    _ ->
                        Json.Decode.fail "ignored"
            )
        |> Json.Decode.map KeyPressed

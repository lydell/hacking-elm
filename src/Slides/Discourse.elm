module Slides.Discourse exposing (view)

import Html exposing (Html)
import Html.Attributes as Attr


view : List (Html msg)
view =
    [ Html.p [] [ Html.a [ Attr.href "https://discourse.elm-lang.org/", Attr.target "_blank" ] [ Html.text "discourse.elm-lang.org" ] ]
    , Html.p [] [ Html.img [ Attr.src "/images/normalize.png", Attr.width 1026, Attr.height 286 ] [] ]
    , Html.p [] [ Html.img [ Attr.src "/images/response.png", Attr.width 1438, Attr.height 243 ] [] ]
    ]

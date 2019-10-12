module Slides.Discourse exposing (view)

import Html exposing (Html)
import Html.Attributes as Attr


view : List (Html msg)
view =
    [ Html.p [] [ Html.a [ Attr.href "https://discourse.elm-lang.org/", Attr.target "_blank" ] [ Html.text "discourse.elm-lang.org" ] ]
    , Html.p [] [ Html.img [ Attr.src "/images/normalize.png", Attr.width 1026, Attr.height 286 ] [] ]
    , Html.p [] [ Html.code [] [ Html.text """"A" === "A\"""" ], Html.text " ?" ]
    , Html.p [] [ Html.code [] [ Html.text """"Å" === "Å\"""" ], Html.text " ?" ]
    , Html.p [] [ Html.a [ Attr.href "https://apps.timwhitlock.info/unicode/inspect", Attr.target "_blank", Attr.rel "noopener noreferrer" ] [ Html.text "Unicode inspector" ] ]
    ]

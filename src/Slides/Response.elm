module Slides.Response exposing (view)

import Html exposing (Html)
import Html.Attributes as Attr


view : List (Html msg)
view =
    [ Html.p [] [ Html.text "ports?" ]
    , Html.p [] [ Html.code [] [ Html.text """String.normalize "Å\"""" ] ]
    , Html.p [] [ Html.img [ Attr.src "/images/response.png", Attr.width 1438, Attr.height 243 ] [] ]
    ]

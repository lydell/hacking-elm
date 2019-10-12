module Slides.UpperCaseExplained exposing (view)

import Html exposing (Html)
import Html.Attributes as Attr


view : List (Html msg)
view =
    [ Html.p [] [ Html.a [ Attr.href "https://github.com/elm/core/blob/665624859a7a432107059411737e16d1d5cb6373/src/Elm/Kernel/String.js#L180-L183", Attr.target "_blank", Attr.rel "noopener noreferrer" ] [ Html.text "String.toUpper implementation" ] ]
    ]

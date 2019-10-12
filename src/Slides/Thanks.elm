module Slides.Thanks exposing (view)

import Html exposing (Html)


view : List (Html msg)
view =
    [ Html.h1 [] [ Html.text "Thanks!" ]
    , Html.p [] [ Html.text "Hack responsibly." ]
    ]

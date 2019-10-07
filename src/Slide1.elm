module Slide1 exposing (view)

import Html exposing (Html)


view : List (Html msg)
view =
    [ Html.h1 [] [ Html.text "Hacking Elm" ]
    , Html.p [] [ Html.text "Simon Lydell" ]
    ]

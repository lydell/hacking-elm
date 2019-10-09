module Slides.Intro exposing (view)

import Html exposing (Html)


view : List (Html msg)
view =
    [ Html.div []
        [ Html.h1 [] [ Html.text "Hacking Elm" ]
        , Html.p [] [ Html.text "Simon Lydell" ]
        ]
    ]

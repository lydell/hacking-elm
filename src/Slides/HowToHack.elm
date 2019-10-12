module Slides.HowToHack exposing (view)

import Html exposing (Html)


view : List (Html msg)
view =
    [ Html.h1 [] [ Html.text "How to hack Elm" ]
    , Html.p [] [ Html.strong [] [ Html.text "You can’t." ] ]
    , Html.p [] [ Html.text "…but you can hack JavaScript" ]
    ]

module Slides.Conclusions exposing (view)

import Html exposing (Html)


view : List (Html msg)
view =
    [ Html.h1 [] [ Html.text "Should you do this?" ]
    , Html.p [] [ Html.text "Probably not." ]
    , Html.p [] [ Html.text "Easy to get wrong." ]
    , Html.p [] [ Html.text "Evan could stop using ", Html.code [] [ Html.text ".slice()" ], Html.text " at any time." ]
    , Html.p [] [ Html.text "Performance?" ]
    ]

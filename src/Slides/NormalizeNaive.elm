module Slides.NormalizeNaive exposing (view)

import Html exposing (Html)


view : List (Html msg)
view =
    [ Html.p [] [ Html.text "Å" ]
    ]



--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
-- import StringDebug exposing (debug)
-- [ Html.p [] [ Html.text <| debug "Å" ]
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
-- [ Html.p [] [ Html.text <| debug <| normalize "Å" ]
-- normalize : String -> String
-- normalize string =
--     String.toUpper string
--
-- String.prototype.toUpperCase = String.prototype.normalize;

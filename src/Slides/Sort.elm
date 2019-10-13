module Slides.Sort exposing (view)

import Html exposing (Html)
import Html.Attributes as Attr


list =
    [ "b", "a", "ö", "c", "ä", "å" ]


view : List (Html msg)
view =
    [ Html.div []
        (List.map
            (\item -> Html.div [] [ Html.text item ])
            list
        )
    , Html.p [] [ Html.a [ Attr.href "https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/localeCompare", Attr.target "_blank", Attr.rel "noopener noreferrer" ] [ Html.text "localeCompare" ] ]
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
-- list =
--     List.sort [ "b", "a", "ö", "c", "ä", "å"]
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
-- list =
--     List.sort [ "b", "a", "ö", "c", "ä", "å", "file1.png", "file2.png", "file10.png" ]
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
-- list =
--     List.sortWith LocaleCompare.compare [ "b", "a", "ö", "c", "ä", "å", "file1.png", "file2.png", "file10.png" ]
--
-- import LocaleCompare
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
-- list =
--     List.sortWith
--         (LocaleCompare.compare "sv" LocaleCompare.defaultOptions)
--         [ "b", "a", "ö", "c", "ä", "å", "file1.png", "file2.png", "file10.png" ]
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
-- list =
--     List.sortWith
--         (LocaleCompare.compare "sv" { defaultOptions | numeric = True })
--         [ "b", "a", "ö", "c", "ä", "å", "file1.jpg", "file2.jpg", "file10.jpg" ]
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
-- list =
--     List.sortWith
--         (LocaleCompare.compare "oops" { defaultOptions | numeric = True })
--         [ "b", "a", "ö", "c", "ä", "å", "file1.jpg", "file2.jpg", "file10.jpg" ]

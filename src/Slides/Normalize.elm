module Slides.Normalize exposing (view)

import Html exposing (Html)
import StringDebug exposing (debug)


view : List (Html msg)
view =
    [ Html.p [] [ Html.text <| debug <| normalize "Å" ]
    ]


normalize : String -> String
normalize string =
    String.toUpper string



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
-- 999999999999999
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
-- normalize : String -> String
-- normalize string =
--     String.slice 999999999999999 0 string
--
-- const originalSlice = String.prototype.slice;
-- String.prototype.slice = function slice(start, end) {
--   if (start === 999999999999999) {
--     return this.normalize();
--   }
--   return originalSlice.call(this, start, end);
-- };
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
-- type Form
--     = NFC
--     | NFD
--     | NFKC
--     | NFKD
-- formToInt : Form -> Int
-- formToInt form =
--     case form of
--         NFC ->
--             1
--         NFD ->
--             2
--         NFKC ->
--             3
--         NFKD ->
--             4
-- normalize : Form -> String -> String
-- normalize form string =
--     String.slice 999999999999999 (formToInt form) string
-- [ Html.p [] [ Html.text <| debug <| normalize NFC "Å" ]
--
-- const originalSlice = String.prototype.slice;
-- String.prototype.slice = function slice(start, end) {
--   if (start === 999999999999999) {
--     switch (end) {
--       case 1:
--         return this.normalize("NFC");
--       case 2:
--         return this.normalize("NFD");
--       case 3:
--         return this.normalize("NFKC");
--       case 4:
--         return this.normalize("NFKD");
--     }
--   }
--   return originalSlice.call(this, start, end);
-- };

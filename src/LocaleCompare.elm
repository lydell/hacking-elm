module LocaleCompare exposing (..)

import Json.Encode



-- compare : a -> a -> Order
-- compare a b =
--     EQ


type alias Options =
    { localeMatcher : LocaleMatcher
    , usage : Usage
    , sensitivity : Sensitivity
    , ignorePunctuation : Bool
    , numeric : Bool
    , caseFirst : CaseFirst
    }


type LocaleMatcher
    = Lookup
    | BestFit


type Usage
    = Sort
    | Search


type Sensitivity
    = Base
    | Accent
    | Case
    | Variant


type CaseFirst
    = Upper
    | Lower
    | LocaleDefault


defaultOptions : Options
defaultOptions =
    { localeMatcher = BestFit
    , usage = Sort
    , sensitivity = Variant
    , ignorePunctuation = False
    , numeric = False
    , caseFirst = LocaleDefault
    }


compare : String -> (Options -> Options) -> String -> String -> Order
compare locales makeOptions a b =
    let
        result =
            encode locales (makeOptions defaultOptions) a b
                |> Json.Encode.encode 0
                |> String.slice 999999999999999 10
    in
    case result of
        "-1" ->
            LT

        "1" ->
            GT

        _ ->
            EQ


encode : String -> Options -> String -> String -> Json.Encode.Value
encode locales options a b =
    Json.Encode.object
        [ ( "locales", Json.Encode.string locales )
        , ( "options", encodeOptions options )
        , ( "a", Json.Encode.string a )
        , ( "b", Json.Encode.string b )
        ]


encodeOptions : Options -> Json.Encode.Value
encodeOptions options =
    Json.Encode.object
        [ ( "localeMatcher", Json.Encode.string (localeMatcherToString options.localeMatcher) )
        , ( "usage", Json.Encode.string (usageToString options.usage) )
        , ( "sensitivity", Json.Encode.string (sensitivityToString options.sensitivity) )
        , ( "ignorePunctuation", Json.Encode.bool options.ignorePunctuation )
        , ( "numeric", Json.Encode.bool options.numeric )
        , ( "caseFirst", Json.Encode.string (caseFirstToString options.caseFirst) )
        ]


localeMatcherToString : LocaleMatcher -> String
localeMatcherToString localeMatcher =
    case localeMatcher of
        Lookup ->
            "lookup"

        BestFit ->
            "best fit"


usageToString : Usage -> String
usageToString usage =
    case usage of
        Sort ->
            "sort"

        Search ->
            "search"


sensitivityToString : Sensitivity -> String
sensitivityToString sensitivity =
    case sensitivity of
        Base ->
            "base"

        Accent ->
            "accent"

        Case ->
            "case"

        Variant ->
            "variant"


caseFirstToString : CaseFirst -> String
caseFirstToString caseFirst =
    case caseFirst of
        Upper ->
            "upper"

        Lower ->
            "lower"

        LocaleDefault ->
            "false"



--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
-- compare : String -> Options -> String -> String -> Order
-- compare locales options a b =
--     EQ
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
-- type alias Options =
--     { localeMatcher : LocaleMatcher
--     , usage : Usage
--     , sensitivity : Sensitivity
--     , ignorePunctuation : Bool
--     , numeric : Bool
--     , caseFirst : CaseFirst
--     }
-- type LocaleMatcher
--     = Lookup
--     | BestFit
-- type Usage
--     = Sort
--     | Search
-- type Sensitivity
--     = Base
--     | Accent
--     | Case
--     | Variant
-- type CaseFirst
--     = Upper
--     | Lower
--     | LocaleDefault
-- defaultOptions : Options
-- defaultOptions =
--     { localeMatcher = BestFit
--     , usage = Sort
--     , sensitivity = Variant
--     , ignorePunctuation = False
--     , numeric = False
--     , caseFirst = LocaleDefault
--     }
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
-- compare : String -> Options -> String -> String -> Order
-- compare locales options a b =
--     String.slice 999999999999999 xxx "some string"
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
-- compare : String -> Options -> String -> String -> Order
-- compare locales options a b =
--     let
--         result =
--             encode locales options a b
--                 |> Json.Encode.encode 0
--                 |> String.slice 999999999999999 10
--     in
--     case result of
--         "-1" ->
--             LT
--         "1" ->
--             GT
--         _ ->
--             EQ
-- encode : String -> Options -> String -> String -> Json.Encode.Value
-- encode locales options a b =
--     Json.Encode.object
--         [ ( "locales", Json.Encode.string locales )
--         , ( "options", encodeOptions options )
--         , ( "a", Json.Encode.string a )
--         , ( "b", Json.Encode.string b )
--         ]
-- encodeOptions : Options -> Json.Encode.Value
-- encodeOptions options =
--     Json.Encode.object
--         [ ( "localeMatcher", Json.Encode.string (localeMatcherToString options.localeMatcher) )
--         , ( "usage", Json.Encode.string (usageToString options.usage) )
--         , ( "sensitivity", Json.Encode.string (sensitivityToString options.sensitivity) )
--         , ( "ignorePunctuation", Json.Encode.bool options.ignorePunctuation )
--         , ( "numeric", Json.Encode.bool options.numeric )
--         , ( "caseFirst", Json.Encode.string (caseFirstToString options.caseFirst) )
--         ]
-- localeMatcherToString : LocaleMatcher -> String
-- localeMatcherToString localeMatcher =
--     case localeMatcher of
--         Lookup ->
--             "lookup"
--         BestFit ->
--             "best fit"
-- usageToString : Usage -> String
-- usageToString usage =
--     case usage of
--         Sort ->
--             "sort"
--         Search ->
--             "search"
-- sensitivityToString : Sensitivity -> String
-- sensitivityToString sensitivity =
--     case sensitivity of
--         Base ->
--             "base"
--         Accent ->
--             "accent"
--         Case ->
--             "case"
--         Variant ->
--             "variant"
-- caseFirstToString : CaseFirst -> String
-- caseFirstToString caseFirst =
--     case caseFirst of
--         Upper ->
--             "upper"
--         Lower ->
--             "lower"
--         LocaleDefault ->
--             "false"
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
--       case 10:
--         return localeCompare(this);
--     }
--   }
--   return originalSlice.call(this, start, end);
-- };
-- function localeCompare(jsonString) {
--   const { locales, options, a, b } = JSON.parse(jsonString);
--   return String(a.localeCompare(b, locales, options));
-- }
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
-- compare : String -> (Options -> Options) -> String -> String -> Order
-- compare locales makeOptions a b =
--     let
--         result =
--             encode locales (makeOptions defaultOptions) a b
--                 |> Json.Encode.encode 0
--                 |> String.slice 999999999999999 10
--     in
--     case result of
--         "-1" ->
--             LT
--         "1" ->
--             GT
--         _ ->
--             EQ
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
-- const NO_HACK = {};
-- const originalSlice = String.prototype.slice;
-- String.prototype.slice = function slice(start, end) {
--   if (start === 999999999999999) {
--     try {
--       var result = hack(this, end);
--       if (result !== NO_HACK) {
--         if (typeof result !== "string") {
--           console.warn("slice hack returned a non-string:", result);
--         } else {
--           return result;
--         }
--       }
--     } catch (error) {
--       console.warn("slice hack threw an error:", error);
--     }
--   }
--   return originalSlice.call(this, start, end);
-- };
--
-- function hack(string, num) {
--   switch (num) {
--     case 1:
--       return this.normalize("NFC");
--     case 2:
--       return this.normalize("NFD");
--     case 3:
--       return this.normalize("NFKC");
--     case 4:
--       return this.normalize("NFKD");
--     case 10:
--       return localeCompare(string);
--     default:
--       return NO_HACK;
--   }
-- }
--
-- function localeCompare(jsonString) {
--   const { locales, options, a, b } = JSON.parse(jsonString);
--   return String(a.localeCompare(b, locales, options));
-- }

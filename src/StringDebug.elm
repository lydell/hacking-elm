module StringDebug exposing (debug)


debug : String -> String
debug =
    debugHelper ""


debugHelper : String -> String -> String
debugHelper result string =
    case string of
        "" ->
            String.dropLeft 1 result

        _ ->
            debugHelper (result ++ " " ++ String.left 1 string) (String.dropLeft 1 string)

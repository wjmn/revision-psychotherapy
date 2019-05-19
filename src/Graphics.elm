module Graphics exposing (show, testSvg)

import Color exposing (Color)
import Html exposing (..)
import Svg exposing (Svg)
import TypedSvg exposing (..)
import TypedSvg.Attributes exposing (..)
import TypedSvg.Types exposing (..)


show : List (Svg msg) -> Html msg
show svgList =
    svg
        [ width <| px 240
        , height <| px 240
        , viewBox 0 0 240 240
        ]
        svgList


testSvg : List (Svg msg)
testSvg =
    [ g [ transform [ Translate 120 120 ] ] <| pill Color.red Color.black ]


pill : Color -> Color -> List (Svg msg)
pill topcol bottomcol =
    let
        pillHalf xloc yloc col multiply =
            [ rect
                [ x <| px xloc
                , y <| px yloc
                , width <| px 30
                , height <| px 45
                , rx <| px 15
                , fill <| Fill col
                ]
                []
            , rect
                [ x <| px <| xloc
                , y <| px <| yloc + (multiply * 20)
                , width <| px 30
                , height <| px 25
                , fill <| Fill col
                ]
                []
            ]
    in
    pillHalf 0 0 topcol 1 ++ pillHalf 0 45 bottomcol 0

module Slides.Pharmacotherapy exposing (testSlide)

import Graphics exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


testSlide =
    Slide "TESTSLIDE" (makeCard testSvg) Single ""


makeCard svg =
    div [ class "left-and-right" ]
        [ div [ class "left" ]
            [ div [ class "card" ] [ show svg ] ]
        , div [ class "right" ]
            [ p [] [ text "TEST" ]
            ]
        ]

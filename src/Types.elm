module Types exposing (Model, Msg(..), Slide, SlideType(..), defaultModel)

import Array exposing (Array)
import Html exposing (Html)


type alias Model =
    { slides : Array Slide
    , currentSlide : Int
    }


type Msg
    = NoOp
    | Next
    | Previous


type SlideType
    = Single
    | Revealed Bool


type alias Slide =
    { title : String
    , content : Html Msg
    , slideType : SlideType
    , notes : String
    }


defaultModel : List Slide -> Model
defaultModel slideList =
    { slides = Array.fromList slideList, currentSlide = 0 }

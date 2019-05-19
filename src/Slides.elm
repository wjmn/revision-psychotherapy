module Slides exposing (slides)

import Slides.Pharmacotherapy as Pharm
import Slides.Title as Title
import Types exposing (..)


slides : List Slide
slides =
    [ Title.slide
    , Pharm.testSlide
    ]

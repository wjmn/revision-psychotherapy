module Slides.Title exposing (slide)

import Html exposing (..)
import Html.Attributes exposing (..)
import Markdown
import Types exposing (..)


slide : Slide
slide =
    { title = "Revision Lecture on Psychotherapy", content = content, slideType = Single, notes = "" }


content : Html Msg
content =
    div [] <|
        Markdown.toHtml Nothing mdcontent


mdcontent =
    """

## Note!

- This is a quick reference.
- Learn from real life as much as possible.
- You **must** recall, review and repeat.
- A 45 minute lecture by itself is useless.

## We will cover:

  1. Antidepressants
  2. Mood stabilisers
  3. Anxiolytics
  4. Antipsychotics
  5. Substances
  6. Psychotherapy

"""

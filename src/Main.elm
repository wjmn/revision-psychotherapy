module Main exposing (main)

import Array
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Slides
import Types exposing (..)



---- MODEL ----


init : ( Model, Cmd Msg )
init =
    ( defaultModel Slides.slides, Cmd.none )



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Next ->
            if model.currentSlide < Array.length model.slides - 1 then
                ( { model | currentSlide = model.currentSlide + 1 }, Cmd.none )

            else
                ( { model | currentSlide = 0 }, Cmd.none )

        Previous ->
            if model.currentSlide > 0 then
                ( { model | currentSlide = model.currentSlide - 1 }, Cmd.none )

            else
                ( { model | currentSlide = Array.length model.slides - 1 }, Cmd.none )



---- VIEW ----


titleToId : String -> String
titleToId =
    String.replace " " ""


contain : Slide -> Html Msg
contain slide =
    div [ class "container" ]
        [ div [ class "slide", id <| titleToId slide.title ] [ h1 [] [ text slide.title ], div [ class "content" ] [ slide.content ] ]
        ]


anchor : Slide -> Html Msg
anchor slide =
    a [ href <| "#" ++ titleToId slide.title ] [ text slide.title ]


view : Model -> Html Msg
view model =
    let
        maybeSlide =
            Array.get model.currentSlide model.slides
    in
    div []
        [ div [] <| Array.toList <| Array.map contain model.slides
        , div [ class "controls" ] <| Array.toList <| Array.map anchor model.slides
        ]



{-
   case maybeSlide of
       Just slide ->
           div [ class "container" ]
               [ div [ class "slide" ] [ h1 [] [ text slide.title ], slide.content ]
               , div [ class "controls" ] [ button [ onClick Previous, class "left" ] [ text "Previous" ], button [ onClick Next, class "right" ] [ text "Next" ] ]
               ]

       Nothing ->
           div [ class "no-slide" ] [ text "We're sorry, there was no slide to show." ]

-}
---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }

module Main exposing (..)

import Html exposing (Html, text, ul, div, audio, p, h1, h2, button, input, label)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (class, src, id, type_, controls, placeholder)
import Http
import Json.Decode as Decode


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { title : String
    , message : String
    }


model : Model
model =
    { title = "This is not used..."
    , message = "...so what is the point?"
    }


init : ( Model, Cmd Msg )
init =
    ( Model "Album 1" "Messages for you go here"
    , Cmd.none
    )



-- UPDATE


type Msg
    = GetIt
    | NewAlbum (Result Http.Error String)
    | Change String
    | ToggleFave


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetIt ->
            ( model, getIt )

        NewAlbum (Ok newTitle) ->
            ( { model | title = newTitle, message = "You fetched an album name." }, Cmd.none )

        NewAlbum (Err _) ->
            ( { model | message = "Dang, the fetch failed." }, Cmd.none )

        Change userInput ->
            ( { model | message = "You typed " ++ userInput }, Cmd.none )

        ToggleFave ->
            ( { model | message = "You faved something." }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text model.title ]
        , p [] [ text model.message ]
        , button [ onClick GetIt ] [ text "Fetch another album name" ]
        , input [ placeholder "Type something", onInput Change ] []
        , viewAlbum album1
        , viewAlbum album2
        ]


viewTune tune =
    div [ class "audio-player" ]
        [ p [] [ text tune.name ]
        , audio
            [ src tune.source
            , id "audio-player"
            , type_ "audio/ogg"
            , controls True
            ]
            []
        ]


viewAlbum album =
    div []
        [ h2 [] [ text album.title ]
        , checkbox ToggleFave "Fave"
        , ul [] (List.map viewTune album.tracks)
        ]


checkbox : msg -> String -> Html msg
checkbox msg name =
    label []
        [ input [ type_ "checkbox", onClick msg ] []
        , text name
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- HTTP


getIt : Cmd Msg
getIt =
    Http.send NewAlbum (Http.get "data/album1.json" decodeAlbumTitle)


decodeAlbumTitle : Decode.Decoder String
decodeAlbumTitle =
    Decode.at [ "title" ] Decode.string



-- DATA


album1 =
    { title = "Grow Up"
    , tracks =
        [ { name = "hey"
          , source = "http://developer.mozilla.org/@api/deki/files/2926/=AudioTest_(1).ogg"
          , type_ = "audio/ogg"
          }
        , { name = "you"
          , source = "http://developer.mozilla.org/@api/deki/files/2926/=AudioTest_(1).ogg"
          , type_ = "audio/ogg"
          }
        , { name = "guys"
          , source = "http://developer.mozilla.org/@api/deki/files/2926/=AudioTest_(1).ogg"
          , type_ = "audio/ogg"
          }
        ]
    }


album2 =
    { title = "Die Young"
    , tracks =
        [ { name = "hey"
          , source = "http://developer.mozilla.org/@api/deki/files/2926/=AudioTest_(1).ogg"
          , type_ = "audio/ogg"
          }
        , { name = "you"
          , source = "http://developer.mozilla.org/@api/deki/files/2926/=AudioTest_(1).ogg"
          , type_ = "audio/ogg"
          }
        , { name = "guys"
          , source = "http://developer.mozilla.org/@api/deki/files/2926/=AudioTest_(1).ogg"
          , type_ = "audio/ogg"
          }
        ]
    }

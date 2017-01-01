import Html exposing (Html, text, ul, div, audio, p, h1, h2, button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, src, id, type_, controls)
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
  }


model : Model
model =
  { title = "this is not used"
  }

init : (Model, Cmd Msg)
init =
  ( Model "Album 1"
  , Cmd.none
  )




-- UPDATE


type Msg
  = GetIt
  | NewAlbum (Result Http.Error String)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GetIt ->
      (model, getIt)

    NewAlbum (Ok newUrl) ->
      ({ model | title = "Album 2"}, Cmd.none)

    NewAlbum (Err _) ->
      ({ model | title = "Whoops"}, Cmd.none)



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text model.title ]
    , button [ onClick GetIt ] [ text "New Album" ]
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
  [ h2 [] [ text album.title]
  , ul [] (List.map viewTune album.tracks)
  ]



-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- HTTP


getIt : Cmd Msg
getIt =
  Http.send NewAlbum (Http.get "someurl" decodeAlbumsUrl)

decodeAlbumsUrl : Decode.Decoder String
decodeAlbumsUrl =
  Decode.at ["data", "url"] Decode.string

-- DATA


album1 =
  { title = "Grow Up"
  , tracks = [
    { name = "hey"
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
  , tracks = [
    { name = "hey"
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

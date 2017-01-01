import Html exposing (Html, text, ul, div, audio, p, h1, h2)
import Html.Attributes exposing (class, src, id, type_, controls)

main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
  }

type alias Model =
  { title : String
  }


model : Model
model =
  { title = "Album 1"
  }

type Msg
  = ChangeAlbum

update : Msg -> Model -> Model
update msg model =
  case msg of
    ChangeAlbum ->
      { model | title = "Album 2"}

view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text model.title ]
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

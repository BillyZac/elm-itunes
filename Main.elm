import Html exposing (text, ul, div, audio, p, h1, h2)
import Html.Attributes exposing (class, src, id, type_, controls)

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

main =
  div []
  [ h1 [] [ text "elmtunes" ]
  , viewAlbum album1
  , viewAlbum album2
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

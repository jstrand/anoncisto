import Presentation exposing (..)
import Formatting exposing (..)

main = markdownSlidesViewer slides "ws://localhost:9000"

slides =
    [ title
    , one
    , two
    ]
    ++ threes


title = """
# Title slide
* One
* Two
* Three
"""


one = """
# Slide 2
* Four
* Five
* Six
"""


two =
    one |> makeBold "Five"


three = """
# Reveal 1,2,3
* 1
* 2
* 3
"""

threes =
    revealBullets three
import Presentation exposing (..)

main = markdownSlidesViewer slides "ws://localhost:9000"

slides = [title, one]

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


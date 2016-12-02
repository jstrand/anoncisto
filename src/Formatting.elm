module Formatting exposing
    ( revealBullets
    , makeBold
    )

{-| Functions for formatting slides.

# Styling
@docs makeBold

# "Animation"
@docs revealBullets

-}

import String
import List.Extra
import Regex


{-| Returns the given "needle" as bold in the given markdown text.

    makeBold "Monkey" "A Monkey Wrench" -> "A **Monkey Wrench**"
-}
makeBold : String -> String -> String
makeBold needle =
  Regex.replace Regex.All (Regex.regex needle) (\{match} -> ("**" ++ match ++ "**"))


isBullet : String -> Bool
isBullet = String.startsWith "*"


joinLines =
    String.join "\n"


{-| Reveal the bulleted part of a text gradually

    text = """
# Reveal 1,2,3
* 1
* 2
* 3
"""

    revealBullets text

Results in the list

    [ "# Reveal 1,2,3"
    , "# Reveal 1,2,3\n* 1"
    , "# Reveal 1,2,3\n* 1\n* 2"
    , "# Reveal 1,2,3\n* 1\n* 2\n* 3"
    ]
-}
revealBullets : String -> List String
revealBullets text =
    let
        (before, bullets, after) = fromBullets text
        prefix = joinLines before
        postfix = joinLines after
    in
        revealWithPreAndPostFix prefix bullets postfix


fromBullets : String -> (List String, List String, List String)
fromBullets text =
    let
        lines = String.lines text
        bullets = List.filter isBullet lines
        notBullet = not << isBullet
        beforeBullets = List.Extra.takeWhile notBullet lines
        afterBullets = List.Extra.takeWhileRight notBullet lines
    in
        (beforeBullets, bullets, afterBullets)


revealWithPreAndPostFix : String -> List String -> String -> List String
revealWithPreAndPostFix pre reveal post =
    let
        embrace x = pre ++ "\n" ++ x ++ "\n" ++ post
    in
        List.map embrace <| gradualReveal reveal


-- ["A", "B", "C"] -> ["\n", "A\n", "AB\n", "ABC\n"]
gradualReveal : List String -> List String
gradualReveal =
    List.map joinLines << List.Extra.inits


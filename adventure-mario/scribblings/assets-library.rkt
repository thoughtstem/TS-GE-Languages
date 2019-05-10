#lang scribble/manual

@require[scribble/extract]
@require[ game-engine
         "../assets.rkt"]

@title{Assets Library}

@section{Characters}

@; Big Marios
@defthing[bigmario01-sprite animated-sprite?]
@(sprite->sheet bigmario01-sprite)

@defthing[bigmario02-sprite animated-sprite?]
@(sprite->sheet bigmario02-sprite)

@defthing[bigmario03-sprite animated-sprite?]
@(sprite->sheet bigmario03-sprite)

@defthing[bigmario04-sprite animated-sprite?]
@(sprite->sheet bigmario04-sprite)

@defthing[bigmario05-sprite animated-sprite?]
@(sprite->sheet bigmario05-sprite)

@defthing[bigmario06-sprite animated-sprite?]
@(sprite->sheet bigmario06-sprite)

@defthing[bigmario07-sprite animated-sprite?]
@(sprite->sheet bigmario07-sprite)

@defthing[bigmario08-sprite animated-sprite?]
@(sprite->sheet bigmario08-sprite)

@defthing[bigmario09-sprite animated-sprite?]
@(sprite->sheet bigmario09-sprite)

@defthing[bigmario10-sprite animated-sprite?]
@(sprite->sheet bigmario10-sprite)

@defthing[bigmario11-sprite animated-sprite?]
@(sprite->sheet bigmario11-sprite)

@; Small Marios
@defthing[smallmario01-sprite animated-sprite?]
@(sprite->sheet smallmario01-sprite)

@defthing[smallmario02-sprite animated-sprite?]
@(sprite->sheet smallmario02-sprite)

@defthing[smallmario03-sprite animated-sprite?]
@(sprite->sheet smallmario03-sprite)

@defthing[smallmario04-sprite animated-sprite?]
@(sprite->sheet smallmario04-sprite)

@defthing[smallmario05-sprite animated-sprite?]
@(sprite->sheet smallmario05-sprite)

@defthing[smallmario06-sprite animated-sprite?]
@(sprite->sheet smallmario06-sprite)

@defthing[smallmario07-sprite animated-sprite?]
@(sprite->sheet smallmario07-sprite)

@defthing[smallmario08-sprite animated-sprite?]
@(sprite->sheet smallmario08-sprite)

@defthing[smallmario09-sprite animated-sprite?]
@(sprite->sheet smallmario09-sprite)

@defthing[smallmario10-sprite animated-sprite?]
@(sprite->sheet smallmario10-sprite)

@defthing[smallmario11-sprite animated-sprite?]
@(sprite->sheet smallmario11-sprite)


@;----
@(include-section adventure/scribblings/assets-library)

@;---
@section{Sprite Sheets}

@(include-extracted "../assets.rkt")
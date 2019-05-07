#lang scribble/manual

@require[scribble/extract]
@require[ game-engine
         "../assets.rkt"]

@title{Assets Library}

@section{Characters}

@defthing[harrypotter-sprite animated-sprite?]
@(sprite->sheet harrypotter-sprite)

@;----
@(include-section adventure/scribblings/assets-library)

@;---
@section{Sprite Sheets}

@(include-extracted "../assets.rkt")
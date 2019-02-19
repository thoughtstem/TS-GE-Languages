#lang scribble/manual

@require[scribble/extract]
@require[game-engine
         game-engine-demos-common]

@title{Battle Arena Assets}

@section{Random Character}

@defproc[(random-character-sprite) animated-sprite?]
Use this function to get a random character each time.

@(include-extracted "../assets.rkt")

@section{Backgrounds}

@defthing[FOREST-BG image?]
@(scale .25 FOREST-BG)

@defthing[SNOW-BG image?]
@(scale .25 SNOW-BG)

@defthing[DESERT-BG image?]
@(scale .25 DESERT-BG)

@defthing[LAVA-BG image?]
@(scale .25 LAVA-BG)

@defthing[PINK-BG image?]
@(scale .25 PINK-BG)

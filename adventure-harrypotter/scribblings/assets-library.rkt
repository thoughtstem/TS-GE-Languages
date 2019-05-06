#lang scribble/manual

@require[scribble/extract]
@require[ game-engine
         "../assets.rkt"]

@title{Assets Library}

@section{Characters}

@defthing[harrypotter-sprite animated-sprite?]
@(sprite->sheet harrypotter-sprite)
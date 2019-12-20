#lang scribble/manual

@require[scribble/extract]
@require[ game-engine
         "../assets.rkt"]

@title{Assets Library}

@section{Characters}

@defthing[harrypotter-sprite animated-sprite?]
@(sprite->sheet harrypotter-sprite)

@defthing[flyingbook-sprite animated-sprite?]
@(sprite->sheet flyingbook-sprite)
  
@defthing[pumpkin-sprite animated-sprite?]
@(sprite->sheet pumpkin-sprite)
  
@defthing[magiccauldron-sprite animated-sprite?]
@(sprite->sheet magiccauldron-sprite)
  
@defthing[snape-sprite animated-sprite?]
@(sprite->sheet snape-sprite)
  
@defthing[tentacula-sprite animated-sprite?]
@(sprite->sheet tentacula-sprite)
  
@defthing[hagrid-sprite animated-sprite?]
@(sprite->sheet hagrid-sprite)
  
@defthing[oldwizard-sprite animated-sprite?]
@(sprite->sheet oldwizard-sprite)

@defthing[potion-sprite animated-sprite?]
@potion-sprite

@;----
@(include-section adventure/scribblings/assets-library)

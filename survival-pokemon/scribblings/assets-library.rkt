#lang scribble/manual

@require[scribble/extract]
@require[ game-engine
         "../assets.rkt"]

@title{Assets Library}

@section{Pokemon}

@defthing[armoredmewtwo-sprite animated-sprite?]
@(sprite->sheet armoredmewtwo-sprite)

@defthing[pikachu-sprite animated-sprite?]
@(sprite->sheet pikachu-sprite)

@defthing[pikachurun-sprite animated-sprite?]
@(sprite->sheet pikachurun-sprite)



@section{Trainers}

@defthing[redboy-sprite animated-sprite?]
@(sprite->sheet redboy-sprite)

@defthing[redgirl-sprite animated-sprite?]
@(sprite->sheet redgirl-sprite)

@defthing[greenboy-sprite animated-sprite?]
@(sprite->sheet greenboy-sprite)

@defthing[greengirl-sprite animated-sprite?]
@(sprite->sheet greengirl-sprite)

@defthing[james-sprite animated-sprite?]
@(sprite->sheet james-sprite)


@section{Grunts}

@defthing[jessie-sprite animated-sprite?]
@(sprite->sheet jessie-sprite)

@defthing[james-sprite animated-sprite?]
@(sprite->sheet james-sprite)

@(include-section battle-arena/scribblings/assets-library)

@section{Sprite Sheets}

@(include-extracted "../assets.rkt")
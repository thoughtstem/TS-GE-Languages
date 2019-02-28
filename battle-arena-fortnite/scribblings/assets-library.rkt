#lang scribble/manual

@require[scribble/extract]
@require[ game-engine
         "../assets.rkt"]

@title{Assets Library}

@section{Heroes}

@defthing[cecil-sprite animated-sprite?]
@(sprite->sheet cecil-sprite)

@defthing[constructor-sprite animated-sprite?]
@(sprite->sheet constructor-sprite)

@defthing[ninja-sprite animated-sprite?]
@(sprite->sheet ninja-sprite)

@defthing[outlander-sprite animated-sprite?]
@(sprite->sheet outlander-sprite)

@defthing[soldier-sprite animated-sprite?]
@(sprite->sheet soldier-sprite)

@(include-section battle-arena/scribblings/assets-library)

@section{Sprite Sheets}

@(include-extracted "../assets.rkt")
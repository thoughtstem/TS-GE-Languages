#lang scribble/manual

@require[scribble/extract]
@require[game-engine
         game-engine-demos-common
         "../assets.rkt"]

@title{Battle Arena Assets}

@section{Avatars and Enemies}

@defproc[(random-character-sprite) animated-sprite?]
@(sprite->sheet mystery-sprite)

@defthing[witch-sprite animated-sprite?]
@(sprite->sheet witch-sprite)

@defthing[caitsith-sprite animated-sprite?]
@(sprite->sheet caitsith-sprite)

@defthing[darkelf-sprite animated-sprite?]
@(sprite->sheet darkelf-sprite)

@defthing[wizard-sprite animated-sprite?]
@(sprite->sheet wizard-sprite)

@defthing[monk-sprite animated-sprite?]
@(sprite->sheet monk-sprite)

@defthing[madscientist-sprite animated-sprite?]
@(sprite->sheet madscientist-sprite)

@defthing[lightelf-sprite animated-sprite?]
@(sprite->sheet lightelf-sprite)

@defthing[darkknight-sprite animated-sprite?]
@(sprite->sheet darkknight-sprite)

@defthing[kavi-sprite animated-sprite?]
@(sprite->sheet kavi-sprite)

@defthing[moderngirl-sprite animated-sprite?]
@(sprite->sheet moderngirl-sprite)

@defthing[moogle-sprite animated-sprite?]
@(sprite->sheet moogle-sprite)

@defthing[pirateboy-sprite animated-sprite?]
@(sprite->sheet pirateboy-sprite)

@defthing[pirategirl-sprite animated-sprite?]
@(sprite->sheet pirategirl-sprite)

@defthing[steampunkboy-sprite animated-sprite?]
@(sprite->sheet steampunkboy-sprite)

@defthing[steampunkgirl-sprite animated-sprite?]
@(sprite->sheet steampunkgirl-sprite)

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

@section{Sprite Sheets}

@(include-extracted "../assets.rkt")
#lang scribble/manual

@require[scribble/extract]
@require[ game-engine
         fandom-sprites-ge]

@title{Assets Library}

@section{Pokemon}

@defthing[bulbasaur-sprite animated-sprite?]
@(sprite->sheet bulbasaur-sprite)

@defthing[ivysaur-sprite animated-sprite?]
@(sprite->sheet ivysaur-sprite)

@defthing[venasaur-sprite animated-sprite?]
@(sprite->sheet venasaur-sprite)

@defthing[squirtle-sprite animated-sprite?]
@(sprite->sheet squirtle-sprite)

@defthing[wartortle-sprite animated-sprite?]
@(sprite->sheet wartortle-sprite)

@defthing[blastoise-sprite animated-sprite?]
@(sprite->sheet blastoise-sprite)

@defthing[charmander-sprite animated-sprite?]
@(sprite->sheet charmander-sprite)

@defthing[charmeleon-sprite animated-sprite?]
@(sprite->sheet charmeleon-sprite)

@defthing[charizard-sprite animated-sprite?]
@(sprite->sheet charizard-sprite)

@defthing[pikachu-sprite animated-sprite?]
@(sprite->sheet pikachu-sprite)

@defthing[pikachurun-sprite animated-sprite?]
@(sprite->sheet pikachurun-sprite)

@defthing[armoredmewtwo-sprite animated-sprite?]
@(sprite->sheet armoredmewtwo-sprite)



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

@; ---
@(include-section survival/scribblings/assets-library)
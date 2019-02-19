#lang scribble/manual

@require[scribble/extract]
@require[ game-engine
         "../assets.rkt"]

@title{Assets Library}

@section{Heros}

@defthing[tonystark-sprite animated-sprite?]
@(sprite->sheet tonystark-sprite)

@defthing[ironman-sprite animated-sprite?]
@(sprite->sheet ironman-sprite)

@defthing[ironpatriot-sprite animated-sprite?]
@(sprite->sheet ironpatriot-sprite)

@defthing[captainamerica-sprite animated-sprite?]
@(sprite->sheet captainamerica-sprite)

@defthing[blackwidow-sprite animated-sprite?]
@(sprite->sheet blackwidow-sprite)

@defthing[hawkeye-sprite animated-sprite?]
@(sprite->sheet hawkeye-sprite)

@defthing[hulk-sprite animated-sprite?]
@(sprite->sheet hulk-sprite)

@defthing[thor-sprite animated-sprite?]
@(sprite->sheet thor-sprite)

@defthing[nickfury-sprite animated-sprite?]
@(sprite->sheet nickfury-sprite)

@defthing[starlord-sprite animated-sprite?]
@(sprite->sheet starlord-sprite)

@defthing[gamora-sprite animated-sprite?]
@(sprite->sheet gamora-sprite)

@defthing[rocketracoon-sprite animated-sprite?]
@(sprite->sheet rocketracoon-sprite)

@defthing[drax-sprite animated-sprite?]
@(sprite->sheet drax-sprite)

@section{Villains}

@defthing[mandarin-sprite animated-sprite?]
@(sprite->sheet mandarin-sprite)

@defthing[redskull-sprite animated-sprite?]
@(sprite->sheet redskull-sprite)

@defthing[wintersoldier-sprite animated-sprite?]
@(sprite->sheet wintersoldier-sprite)

@defthing[loki-sprite animated-sprite?]
@(sprite->sheet loki-sprite)

@defthing[nebula-sprite animated-sprite?]
@(sprite->sheet nebula-sprite)

@defthing[malekith-sprite animated-sprite?]
@(sprite->sheet malekith-sprite)

@defthing[ronan-sprite animated-sprite?]
@(sprite->sheet ronan-sprite)

@(include-section battle-arena/scribblings/assets-library)

@section{Sprite Sheets}

@(include-extracted "../assets.rkt")

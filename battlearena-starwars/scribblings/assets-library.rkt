#lang scribble/manual

@require[scribble/extract]
@require[game-engine
         fandom-sprites-ge]

@title{Assets Library}

@section{Heroes}

@defthing[luke-sprite animated-sprite?]
@(sprite->sheet luke-sprite)

@defthing[obiwan-sprite animated-sprite?]
@(sprite->sheet obiwan-sprite)

@defthing[yoda-sprite animated-sprite?]
@(sprite->sheet yoda-sprite)

@defthing[twilek-sprite animated-sprite?]
@(sprite->sheet twilek-sprite)

@defthing[padawan-sprite animated-sprite?]
@(sprite->sheet padawan-sprite)

@defthing[hansolo-sprite animated-sprite?]
@(sprite->sheet hansolo-sprite)

@defthing[chewie-sprite animated-sprite?]
@(sprite->sheet chewie-sprite)

@defthing[princessleia-sprite animated-sprite?]
@(sprite->sheet princessleia-sprite)

@defthing[rebelpilot-sprite animated-sprite?]
@(sprite->sheet rebelpilot-sprite)

@defthing[lando-sprite animated-sprite?]
@(sprite->sheet lando-sprite)

@defthing[r2d2-sprite animated-sprite?]
@(sprite->sheet r2d2-sprite)

@defthing[c3po-sprite animated-sprite?]
@(sprite->sheet c3po-sprite)

@defthing[c2po-sprite animated-sprite?]
@(sprite->sheet c2po-sprite)

@section{Villains}

@defthing[darthvader-sprite animated-sprite?]
@(sprite->sheet darthvader-sprite)

@defthing[darthmaul-sprite animated-sprite?]
@(sprite->sheet darthmaul-sprite)

@defthing[bobafett-sprite animated-sprite?]
@(sprite->sheet bobafett-sprite)

@defthing[stormtrooper-sprite animated-sprite?]
@(sprite->sheet stormtrooper-sprite)

@;----
@(include-section battlearena/scribblings/assets-library)
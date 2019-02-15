#lang scribble/manual

@(require game-engine
          game-engine-demos-common
          "../lang/main.rkt")

@title{Assets Library}

@section{Avatars, Enemies and NPCs}

@defproc[(random-character-sprite) animated-sprite?]
@;add mystery character silhouette

@defthing[witch-sprite animated-sprite?]
@(sprite->sheet witch-sprite)

@defthing[darkelf-sprite animated-sprite?]
@(sprite->sheet darkelf-sprite)

@defthing[wizard-sprite animated-sprite?]
@(sprite->sheet wizard-sprite)

@defthing[pirate-sprite animated-sprite?]
@(sprite->sheet pirate-sprite)

@defthing[monk-sprite animated-sprite?]
@(sprite->sheet monk-sprite)

@defthing[madscientist-sprite animated-sprite?]
@(sprite->sheet madscientist-sprite)

@defthing[lightelf-sprite animated-sprite?]
@(sprite->sheet lightelf-sprite)

@defthing[bat-sprite animated-sprite?]
@(sprite->sheet bat-sprite)

@defthing[cat-sprite animated-sprite?]
@(sprite->sheet cat-sprite)

@defthing[black-cat-sprite animated-sprite?]
@(sprite->sheet black-cat-sprite)

@defthing[white-cat-sprite animated-sprite?]
@(sprite->sheet white-cat-sprite)

@defthing[snake-sprite animated-sprite?]
@(sprite->sheet snake-sprite)

@defthing[slime-sprite animated-sprite?]
@(sprite->sheet slime-sprite)

@section{Food, Coin, and Crafting Items}

@defthing[apples-sprite animated-sprite?]
@(sprite->sheet apples-sprite)

@defthing[carrot-sprite animated-sprite?]
@(sprite->sheet carrot-sprite)

@defthing[carrot-stew-sprite animated-sprite?]
@(sprite->sheet carrot-stew-sprite)

@defthing[toasted-marshmallow-sprite animated-sprite?]
@(sprite->sheet toasted-marshmallow-sprite)

@defthing[smores-sprite animated-sprite?]
@(sprite->sheet smores-sprite)

@defthing[fish-sprite animated-sprite?]
@(sprite->sheet fish-sprite)

@defthing[cooked-fish-sprite animated-sprite?]
@(sprite->sheet cooked-fish-sprite)

@defthing[fish-stew-sprite animated-sprite?]
@(sprite->sheet fish-stew-sprite)

@defthing[cherry-sprite animated-sprite?]
@(sprite->sheet cherry-sprite)

@defthing[steak-sprite animated-sprite?]
@(sprite->sheet steak-sprite)

@defthing[copper-coin-sprite animated-sprite?]
@(sprite->sheet copper-coin-sprite)

@defthing[silver-coin-sprite animated-sprite?]
@(sprite->sheet silver-coin-sprite)

@defthing[gold-coin-sprite animated-sprite?]
@(sprite->sheet gold-coin-sprite)

@defthing[cauldron-sprite animated-sprite?]
@(sprite->sheet cauldron-sprite)

@defthing[campfire-sprite animated-sprite?]
@(sprite->sheet campfire-sprite)

@defthing[wood-table-sprite animated-sprite?]
@(sprite->sheet wood-table-sprite)

@defthing[chest-sprite animated-sprite?]
@(sprite->sheet chest-sprite)

@defthing[bowl-sprite animated-sprite?]
@(sprite->sheet bowl-sprite)

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


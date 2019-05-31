#lang scribble/manual

@(require game-engine
          game-engine-demos-common
          ;"../assets.rkt"
          )

@require[scribble/extract]

@title{Adventure Game Assets}

@section{Avatars, Enemies and NPCs}

@defproc[(random-character-sprite) animated-sprite?]
@(sprite->sheet mystery-sprite)

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

@defthing[blackcat-sprite animated-sprite?]
@(sprite->sheet blackcat-sprite)

@defthing[whitecat-sprite animated-sprite?]
@(sprite->sheet whitecat-sprite)

@defthing[snake-sprite animated-sprite?]
@(sprite->sheet snake-sprite)

@defthing[slime-sprite animated-sprite?]
@(sprite->sheet slime-sprite)

@section{Food, Coin, and Crafting Items}

@defthing[apples-sprite animated-sprite?]
@(sprite->sheet apples-sprite)

@defthing[carrot-sprite animated-sprite?]
@(sprite->sheet carrot-sprite)

@defthing[carrotstew-sprite animated-sprite?]
@(sprite->sheet carrotstew-sprite)

@defthing[toastedmarshmallow-sprite animated-sprite?]
@(sprite->sheet toastedmarshmallow-sprite)

@defthing[smores-sprite animated-sprite?]
@(sprite->sheet smores-sprite)

@defthing[fish-sprite animated-sprite?]
@(sprite->sheet fish-sprite)

@defthing[cookedfish-sprite animated-sprite?]
@(sprite->sheet cookedfish-sprite)

@defthing[fishstew-sprite animated-sprite?]
@(sprite->sheet fishstew-sprite)

@defthing[cherry-sprite animated-sprite?]
@(sprite->sheet cherry-sprite)

@defthing[steak-sprite animated-sprite?]
@(sprite->sheet steak-sprite)

@defthing[coppercoin-sprite animated-sprite?]
@(sprite->sheet coppercoin-sprite)

@defthing[silvercoin-sprite animated-sprite?]
@(sprite->sheet silvercoin-sprite)

@defthing[goldcoin-sprite animated-sprite?]
@(sprite->sheet goldcoin-sprite)

@defthing[cauldron-sprite animated-sprite?]
@(sprite->sheet cauldron-sprite)

@defthing[campfire-sprite animated-sprite?]
@(sprite->sheet campfire-sprite)

@defthing[woodtable-sprite animated-sprite?]
@(sprite->sheet woodtable-sprite)

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

@section{World Objects}

@defthing[pine-tree entity?]
@(draw-entity (pine-tree))

@defthing[round-tree entity?]
@(draw-entity (round-tree))

@defthing[snow-pine-tree entity?]
@(draw-entity (snow-pine-tree))

@defthing[candy-cane-tree entity?]
@(draw-entity (candy-cane-tree))

@defthing[stone-house entity?]
@(draw-entity (stone-house))

@defthing[wood-house entity?]
@(draw-entity (wood-house))

@defthing[brick-house entity?]
@(draw-entity (brick-house))

@defthing[random-barrels entity?]
@(draw-entity (random-barrels))

@defthing[barrel entity?]
@(draw-entity (barrel))

@defthing[barrels entity?]
@(draw-entity (barrels))

@defthing[random-brown-rock entity?]
@(draw-entity (random-brown-rock))

@defthing[large-brown-rock entity?]
@(draw-entity (large-brown-rock))

@defthing[medium-brown-rock entity?]
@(draw-entity (medium-brown-rock))

@defthing[small-brown-rock entity?]
@(draw-entity (small-brown-rock))

@defthing[random-gray-rock entity?]
@(draw-entity (random-gray-rock))

@defthing[large-gray-rock entity?]
@(draw-entity (large-gray-rock))

@defthing[medium-gray-rock entity?]
@(draw-entity (medium-gray-rock))

@defthing[small-gray-rock entity?]
@(draw-entity (small-gray-rock))


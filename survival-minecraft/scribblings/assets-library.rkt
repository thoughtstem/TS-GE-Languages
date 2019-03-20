#lang scribble/manual

@(require game-engine
          game-engine-demos-common
          "../assets.rkt")

@require[scribble/extract]

@title{Assets Library}

@section{Skins, Mobs and Entities}

@defthing[steve-sprite animated-sprite?]
@(sprite->sheet steve-sprite)

@defthing[alex-sprite animated-sprite?]
@(sprite->sheet alex-sprite)

@defthing[chicken-sprite animated-sprite?]
@(sprite->sheet chicken-sprite)

@defthing[pig-sprite animated-sprite?]
@(sprite->sheet pig-sprite)

@defthing[sheep-sprite animated-sprite?]
@(sprite->sheet sheep-sprite)

@defthing[creeper-sprite animated-sprite?]
@(sprite->sheet creeper-sprite)

@defthing[skeleton-sprite animated-sprite?]
@(sprite->sheet skeleton-sprite)

@defthing[ghast-sprite animated-sprite?]
@(sprite->sheet ghast-sprite)


@section{Ores and Other Items}

@defthing[coalore-sprite image?]
@coalore-sprite

@defthing[ironore-sprite image?]
@ironore-sprite

@defthing[copperore-sprite image?]
@copperore-sprite

@defthing[goldore-sprite image?]
@goldore-sprite

@defthing[meseore-sprite image?]
@meseore-sprite

@defthing[diamondore-sprite image?]
@diamondore-sprite

@defthing[coallump-sprite image?]
@coallump-sprite

@defthing[ironlump-sprite image?]
@ironlump-sprite

@defthing[copperlump-sprite image?]
@copperlump-sprite

@defthing[goldingot-sprite image?]
@goldingot-sprite

@defthing[mesecrystal-sprite image?]
@mesecrystal-sprite

@defthing[diamond-sprite image?]
@diamond-sprite


@(include-section survival/scribblings/assets-library)

@section{Sprite Sheets}
@(include-extracted "../assets.rkt")



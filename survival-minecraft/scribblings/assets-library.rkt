#lang scribble/manual

@(require game-engine
          game-engine-demos-common
          "../assets.rkt")

@require[scribble/extract]

@title{Minecraft Game Assets}

@section{Avatars, Enemies and NPCs}

@defthing[steve-sprite animated-sprite?]
@(sprite->sheet steve-sprite)

@defthing[chicken-sprite animated-sprite?]
@(sprite->sheet chicken-sprite)

@defthing[pig-sprite animated-sprite?]
@(sprite->sheet pig-sprite)

@defthing[creeper-sprite animated-sprite?]
@(sprite->sheet creeper-sprite)

@defthing[skeleton-sprite animated-sprite?]
@(sprite->sheet skeleton-sprite)

@defthing[ghast-sprite animated-sprite?]
@(sprite->sheet ghast-sprite)


@section{Food, Coin, and Crafting Items}

@;add all ores etc


@(include-section survival/scribblings/assets-library)

@section{Sprite Sheets}
@(include-extracted "../assets.rkt")

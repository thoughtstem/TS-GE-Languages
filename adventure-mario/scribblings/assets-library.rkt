#lang scribble/manual

@require[scribble/extract]
@require[ game-engine
         "../assets.rkt"]

@title{Assets Library}

@section{Characters}

@defthing[mario-sprite animated-sprite?]
@(sprite->sheet mario-sprite)

@defthing[luigi-sprite animated-sprite?]
@(sprite->sheet luigi-sprite)

@defthing[princesspeach-sprite animated-sprite?]
@(sprite->sheet princesspeach-sprite)

@defthing[toad-sprite animated-sprite?]
@(sprite->sheet toad-sprite)

@defthing[yoshi1-sprite animated-sprite?]
@(sprite->sheet yoshi1-sprite)

@defthing[yoshi2-sprite animated-sprite?]
@(sprite->sheet yoshi2-sprite)

@; Big Marios
@defthing[bigmario1-sprite animated-sprite?]
@(sprite->sheet bigmario1-sprite)

@defthing[bigmario2-sprite animated-sprite?]
@(sprite->sheet bigmario2-sprite)

@defthing[bigmario3-sprite animated-sprite?]
@(sprite->sheet bigmario3-sprite)

@defthing[bigmario4-sprite animated-sprite?]
@(sprite->sheet bigmario4-sprite)

@; Small Marios
@defthing[smallmario1-sprite animated-sprite?]
@(sprite->sheet smallmario1-sprite)

@defthing[smallmario2-sprite animated-sprite?]
@(sprite->sheet smallmario2-sprite)

@defthing[smallmario3-sprite animated-sprite?]
@(sprite->sheet smallmario3-sprite)

@defthing[smallmario4-sprite animated-sprite?]
@(sprite->sheet smallmario4-sprite)

@section{Enemies}

@defthing[blooper1-sprite animated-sprite?]
@(sprite->sheet blooper1-sprite)

@defthing[blooper2-sprite animated-sprite?]
@(sprite->sheet blooper2-sprite)

@defthing[blooper3-sprite animated-sprite?]
@(sprite->sheet blooper3-sprite)

@defthing[blooper4-sprite animated-sprite?]
@(sprite->sheet blooper4-sprite)

@defthing[bowser1-sprite animated-sprite?]
@(sprite->sheet bowser1-sprite)

@defthing[bowser2-sprite animated-sprite?]
@(sprite->sheet bowser2-sprite)

@defthing[bowser3-sprite animated-sprite?]
@(sprite->sheet bowser3-sprite)

@defthing[bowser4-sprite animated-sprite?]
@(sprite->sheet bowser4-sprite)

@defthing[buzzy1-sprite animated-sprite?]
@(sprite->sheet buzzy1-sprite)

@defthing[buzzy2-sprite animated-sprite?]
@(sprite->sheet buzzy2-sprite)

@defthing[buzzy3-sprite animated-sprite?]
@(sprite->sheet buzzy3-sprite)

@defthing[buzzy4-sprite animated-sprite?]
@(sprite->sheet buzzy4-sprite)

@defthing[cheep1-sprite animated-sprite?]
@(sprite->sheet cheep1-sprite)

@defthing[cheep2-sprite animated-sprite?]
@(sprite->sheet cheep2-sprite)

@defthing[cheep3-sprite animated-sprite?]
@(sprite->sheet cheep3-sprite)

@defthing[cheep4-sprite animated-sprite?]
@(sprite->sheet cheep4-sprite)

@defthing[goomba1-sprite animated-sprite?]
@(sprite->sheet goomba1-sprite)

@defthing[goomba2-sprite animated-sprite?]
@(sprite->sheet goomba2-sprite)

@defthing[goomba3-sprite animated-sprite?]
@(sprite->sheet goomba3-sprite)

@defthing[goomba4-sprite animated-sprite?]
@(sprite->sheet goomba4-sprite)

@defthing[lakitu1-sprite animated-sprite?]
@(sprite->sheet lakitu1-sprite)

@defthing[lakitu2-sprite animated-sprite?]
@(sprite->sheet lakitu2-sprite)

@defthing[lakitu3-sprite animated-sprite?]
@(sprite->sheet lakitu3-sprite)

@defthing[lakitu4-sprite animated-sprite?]
@(sprite->sheet lakitu4-sprite)

@defthing[paratroopa1-sprite animated-sprite?]
@(sprite->sheet paratroopa1-sprite)

@defthing[paratroopa2-sprite animated-sprite?]
@(sprite->sheet paratroopa2-sprite)

@defthing[paratroopa3-sprite animated-sprite?]
@(sprite->sheet paratroopa3-sprite)

@defthing[paratroopa4-sprite animated-sprite?]
@(sprite->sheet paratroopa4-sprite)

@defthing[piranha1-sprite animated-sprite?]
@(sprite->sheet piranha1-sprite)

@defthing[piranha2-sprite animated-sprite?]
@(sprite->sheet piranha2-sprite)

@defthing[piranha3-sprite animated-sprite?]
@(sprite->sheet piranha3-sprite)

@defthing[piranha4-sprite animated-sprite?]
@(sprite->sheet piranha4-sprite)

@defthing[spiny1-sprite animated-sprite?]
@(sprite->sheet spiny1-sprite)

@defthing[spiny2-sprite animated-sprite?]
@(sprite->sheet spiny2-sprite)

@defthing[spiny3-sprite animated-sprite?]
@(sprite->sheet spiny3-sprite)

@defthing[spiny4-sprite animated-sprite?]
@(sprite->sheet spiny4-sprite)

@defthing[troopa1-sprite animated-sprite?]
@(sprite->sheet troopa1-sprite)

@defthing[troopa2-sprite animated-sprite?]
@(sprite->sheet troopa2-sprite)

@defthing[troopa3-sprite animated-sprite?]
@(sprite->sheet troopa3-sprite)

@defthing[troopa4-sprite animated-sprite?]
@(sprite->sheet troopa4-sprite)


@section{Items}

@defthing[block1-sprite animated-sprite?]
@(sprite->sheet block1-sprite)

@defthing[block2-sprite animated-sprite?]
@(sprite->sheet block2-sprite)

@defthing[block3-sprite animated-sprite?]
@(sprite->sheet block3-sprite)

@defthing[block4-sprite animated-sprite?]
@(sprite->sheet block4-sprite)

@defthing[brick1-sprite animated-sprite?]
@(sprite->sheet brick1-sprite)

@defthing[brick2-sprite animated-sprite?]
@(sprite->sheet brick2-sprite)

@defthing[brick3-sprite animated-sprite?]
@(sprite->sheet brick3-sprite)

@defthing[brick4-sprite animated-sprite?]
@(sprite->sheet brick4-sprite)

@defthing[fence1-sprite animated-sprite?]
@(sprite->sheet fence1-sprite)

@defthing[fence2-sprite animated-sprite?]
@(sprite->sheet fence2-sprite)

@defthing[fence3-sprite animated-sprite?]
@(sprite->sheet fence3-sprite)

@defthing[fence4-sprite animated-sprite?]
@(sprite->sheet fence4-sprite)

@defthing[pipe1-sprite animated-sprite?]
@(sprite->sheet pipe1-sprite)

@defthing[pipe2-sprite animated-sprite?]
@(sprite->sheet pipe2-sprite)

@defthing[pipe3-sprite animated-sprite?]
@(sprite->sheet pipe3-sprite)

@defthing[pipe4-sprite animated-sprite?]
@(sprite->sheet pipe4-sprite)

@defthing[question1-sprite animated-sprite?]
@(sprite->sheet question1-sprite)

@defthing[question2-sprite animated-sprite?]
@(sprite->sheet question2-sprite)

@defthing[question3-sprite animated-sprite?]
@(sprite->sheet question3-sprite)

@defthing[question4-sprite animated-sprite?]
@(sprite->sheet question4-sprite)

@;----
@(include-section adventure/scribblings/assets-library)

@;---
@section{Sprite Sheets}

@(include-extracted "../assets.rkt")
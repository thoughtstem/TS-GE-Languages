#lang scribble/manual

@require[scribble/extract]
@require[ game-engine
         "../assets.rkt"
         "../extra-assets.rkt"]

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

@defthing[yoshi-sprite animated-sprite?]
@(sprite->sheet yoshi-sprite)

@defthing[redyoshi-sprite animated-sprite?]
@(sprite->sheet redyoshi-sprite)

@; Big Marios
@defthing[bigmario-sprite animated-sprite?]
@(sprite->sheet bigmario-sprite)

@defthing[orangebigmario-sprite animated-sprite?]
@(sprite->sheet orangebigmario-sprite)

@defthing[bluebigmario-sprite animated-sprite?]
@(sprite->sheet bluebigmario-sprite)

@defthing[greybigmario-sprite animated-sprite?]
@(sprite->sheet greybigmario-sprite)

@; Small Marios
@defthing[smallmario-sprite animated-sprite?]
@(sprite->sheet smallmario-sprite)

@defthing[orangesmallmario-sprite animated-sprite?]
@(sprite->sheet orangesmallmario-sprite)

@defthing[bluesmallmario-sprite animated-sprite?]
@(sprite->sheet bluesmallmario-sprite)

@defthing[greysmallmario-sprite animated-sprite?]
@(sprite->sheet greysmallmario-sprite)

@section{Enemies}

@defthing[blooper-sprite animated-sprite?]
@(sprite->sheet blooper-sprite)

@defthing[blueblooper-sprite animated-sprite?]
@(sprite->sheet blueblooper-sprite)

@defthing[orangeblooper-sprite animated-sprite?]
@(sprite->sheet orangeblooper-sprite)

@defthing[greyblooper-sprite animated-sprite?]
@(sprite->sheet greyblooper-sprite)

@defthing[bowser-sprite animated-sprite?]
@(sprite->sheet bowser-sprite)

@defthing[bluebowser-sprite animated-sprite?]
@(sprite->sheet bluebowser-sprite)

@defthing[orangebowser-sprite animated-sprite?]
@(sprite->sheet orangebowser-sprite)

@defthing[greybowser-sprite animated-sprite?]
@(sprite->sheet greybowser-sprite)

@defthing[buzzy-sprite animated-sprite?]
@(sprite->sheet buzzy-sprite)

@defthing[bluebuzzy-sprite animated-sprite?]
@(sprite->sheet bluebuzzy-sprite)

@defthing[orangebuzzy-sprite animated-sprite?]
@(sprite->sheet orangebuzzy-sprite)

@defthing[greybuzzy-sprite animated-sprite?]
@(sprite->sheet greybuzzy-sprite)

@defthing[cheep-sprite animated-sprite?]
@(sprite->sheet cheep-sprite)

@defthing[bluecheep-sprite animated-sprite?]
@(sprite->sheet bluecheep-sprite)

@defthing[orangecheep-sprite animated-sprite?]
@(sprite->sheet orangecheep-sprite)

@defthing[greycheep-sprite animated-sprite?]
@(sprite->sheet greycheep-sprite)

@defthing[goomba-sprite animated-sprite?]
@(sprite->sheet goomba-sprite)

@defthing[bluegoomba-sprite animated-sprite?]
@(sprite->sheet bluegoomba-sprite)

@defthing[orangegoomba-sprite animated-sprite?]
@(sprite->sheet orangegoomba-sprite)

@defthing[greygoomba-sprite animated-sprite?]
@(sprite->sheet greygoomba-sprite)

@defthing[lakitu-sprite animated-sprite?]
@(sprite->sheet lakitu-sprite)

@defthing[bluelakitu-sprite animated-sprite?]
@(sprite->sheet bluelakitu-sprite)

@defthing[orangelakitu-sprite animated-sprite?]
@(sprite->sheet orangelakitu-sprite)

@defthing[greylakitu-sprite animated-sprite?]
@(sprite->sheet greylakitu-sprite)

@defthing[paratroopa-sprite animated-sprite?]
@(sprite->sheet paratroopa-sprite)

@defthing[blueparatroopa-sprite animated-sprite?]
@(sprite->sheet blueparatroopa-sprite)

@defthing[orangeparatroopa-sprite animated-sprite?]
@(sprite->sheet orangeparatroopa-sprite)

@defthing[greyparatroopa-sprite animated-sprite?]
@(sprite->sheet greyparatroopa-sprite)

@defthing[piranha-sprite animated-sprite?]
@(sprite->sheet piranha-sprite)

@defthing[bluepiranha-sprite animated-sprite?]
@(sprite->sheet bluepiranha-sprite)

@defthing[orangepiranha-sprite animated-sprite?]
@(sprite->sheet orangepiranha-sprite)

@defthing[greypiranha-sprite animated-sprite?]
@(sprite->sheet greypiranha-sprite)

@defthing[spiny-sprite animated-sprite?]
@(sprite->sheet spiny-sprite)

@defthing[bluespiny-sprite animated-sprite?]
@(sprite->sheet bluespiny-sprite)

@defthing[orangespiny-sprite animated-sprite?]
@(sprite->sheet orangespiny-sprite)

@defthing[greyspiny-sprite animated-sprite?]
@(sprite->sheet greyspiny-sprite)

@defthing[troopa-sprite animated-sprite?]
@(sprite->sheet troopa-sprite)

@defthing[bluetroopa-sprite animated-sprite?]
@(sprite->sheet bluetroopa-sprite)

@defthing[orangetroopa-sprite animated-sprite?]
@(sprite->sheet orangetroopa-sprite)

@defthing[greytroopa-sprite animated-sprite?]
@(sprite->sheet greytroopa-sprite)


@section{Items}

@defthing[pinkblock-sprite animated-sprite?]
@(sprite->sheet pinkblock-sprite)

@defthing[blueblock-sprite animated-sprite?]
@(sprite->sheet blueblock-sprite)

@defthing[orangeblock-sprite animated-sprite?]
@(sprite->sheet orangeblock-sprite)

@defthing[greyblock-sprite animated-sprite?]
@(sprite->sheet greyblock-sprite)

@defthing[pinkbrick-sprite animated-sprite?]
@(sprite->sheet pinkbrick-sprite)

@defthing[bluebrick-sprite animated-sprite?]
@(sprite->sheet bluebrick-sprite)

@defthing[orangebrick-sprite animated-sprite?]
@(sprite->sheet orangebrick-sprite)

@defthing[greybrick-sprite animated-sprite?]
@(sprite->sheet greybrick-sprite)

@defthing[pinkfence-sprite animated-sprite?]
@(sprite->sheet pinkfence-sprite)

@defthing[bluefence-sprite animated-sprite?]
@(sprite->sheet bluefence-sprite)

@defthing[orangefence-sprite animated-sprite?]
@(sprite->sheet orangefence-sprite)

@defthing[greyfence-sprite animated-sprite?]
@(sprite->sheet greyfence-sprite)

@defthing[pinkpipe-sprite animated-sprite?]
@(sprite->sheet pinkpipe-sprite)

@defthing[bluepipe-sprite animated-sprite?]
@(sprite->sheet bluepipe-sprite)

@defthing[orangepipe-sprite animated-sprite?]
@(sprite->sheet orangepipe-sprite)

@defthing[greypipe-sprite animated-sprite?]
@(sprite->sheet greypipe-sprite)

@defthing[pinkquestion-sprite animated-sprite?]
@(sprite->sheet pinkquestion-sprite)

@defthing[bluequestion-sprite animated-sprite?]
@(sprite->sheet bluequestion-sprite)

@defthing[orangequestion-sprite animated-sprite?]
@(sprite->sheet orangequestion-sprite)

@defthing[greyquestion-sprite animated-sprite?]
@(sprite->sheet greyquestion-sprite)

@;----
@(include-section adventure/scribblings/assets-library)

@;---
@section{Sprite Sheets}

@(include-extracted "../assets.rkt")
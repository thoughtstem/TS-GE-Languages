#lang at-exp racket

(require ts-kata-util/assets/main
         adventure)

(define-assets-from "assets")

(provide princesspeach-sprite        
         toad-sprite
         luigi-sprite
         mario-sprite
         yoshi-sprite
         redyoshi-sprite
         redmushroom-sprite
         greenmushroom-sprite
         )

(define (easy-sprite sheet r c n)
  (sheet->sprite sheet
                 #:rows r
                 #:columns c
                 #:row-number n
                 #:delay 5))

(define-syntax-rule (define-sprite sheet r c row1 row2 row3 row4)
  (begin
    (provide row1 row2 row3 row4)
    (define row1 (easy-sprite sheet r c 1))
    (define row2 (easy-sprite sheet r c 2))
    (define row3 (easy-sprite sheet r c 3))
    (define row4 (easy-sprite sheet r c 4))))

(define-sprite bigmario-sheet 4 4
  bigmario-sprite
  bluebigmario-sprite
  orangebigmario-sprite
  greybigmario-sprite)

(define-sprite block-sheet 4 1
  pinkblock-sprite
  blueblock-sprite
  orangeblock-sprite
  greyblock-sprite)

(define-sprite blooper-sheet 4 2
  blooper-sprite
  blueblooper-sprite
  orangeblooper-sprite
  greyblooper-sprite)

(define-sprite bowser-sheet 4 4
  bowser-sprite
  bluebowser-sprite
  orangebowser-sprite
  greybowser-sprite)

(define-sprite brick-sheet 4 1
  pinkbrick-sprite
  bluebrick-sprite
  orangebrick-sprite
  greybrick-sprite)

(define-sprite buzzy-sheet 4 2
  buzzy-sprite
  bluebuzzy-sprite
  orangebuzzy-sprite
  greybuzzy-sprite)

(define-sprite cheep-sheet 4 2
  cheep-sprite
  bluecheep-sprite
  orangecheep-sprite
  greycheep-sprite)

(define-sprite fence-sheet 4 1
  pinkfence-sprite
  bluefence-sprite
  orangefence-sprite
  greyfence-sprite)

(define-sprite goomba-sheet 4 2
  goomba-sprite
  bluegoomba-sprite
  orangegoomba-sprite
  greygoomba-sprite)

(define-sprite lakitu-sheet 4 2
  lakitu-sprite
  bluelakitu-sprite
  orangelakitu-sprite
  greylakitu-sprite)

(define-sprite paratroopa-sheet 4 2
  paratroopa-sprite
  blueparatroopa-sprite
  orangeparatroopa-sprite
  greyparatroopa-sprite)

(define-sprite pipe-sheet 4 1
  pinkpipe-sprite
  bluepipe-sprite
  orangepipe-sprite
  greypipe-sprite)

(define-sprite piranha-sheet 4 5
  piranha-sprite
  bluepiranha-sprite
  orangepiranha-sprite
  greypiranha-sprite)

(define-sprite question-sheet 4 1
  pinkquestion-sprite
  bluequestion-sprite
  orangequestion-sprite
  greyquestion-sprite)

(define-sprite smallmario-sheet 4 4
  smallmario-sprite
  bluesmallmario-sprite
  orangesmallmario-sprite
  greysmallmario-sprite)

(define-sprite spiny-sheet 4 2
  spiny-sprite
  bluespiny-sprite
  orangespiny-sprite
  greyspiny-sprite)

(define-sprite troopa-sheet 4 2
  troopa-sprite
  bluetroopa-sprite
  orangetroopa-sprite
  greytroopa-sprite)

(define princesspeach-sprite
  (easy-sprite princesspeach-sheet 1 2 1))

(define toad-sprite
  (easy-sprite toad-sheet 1 2 1))

(define luigi-sprite
  (easy-sprite luigi-sheet 1 2 1))

(define mario-sprite
  (easy-sprite mario-sheet 1 2 1))

(define yoshi-sprite
  (easy-sprite yoshi-sheet 2 2 1))

(define redyoshi-sprite
  (easy-sprite yoshi-sheet 2 2 2))

(define redmushroom-sprite
  (easy-sprite redmushroom-sheet 1 1 1))

(define greenmushroom-sprite
  (easy-sprite greenmushroom-sheet 1 1 1))
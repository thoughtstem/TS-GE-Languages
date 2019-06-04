#lang at-exp racket

(require ts-kata-util/assets/main 
         adventure                
         "./assets.rkt")

(define (easy-sprite sheet r c n)
  (sheet->sprite sheet
                 #:rows r
                 #:columns c
                 #:row-number n
                 #:delay 5))

(define-sprites bigmario-sheet 4 4 2
  bluebigmario-sprite
  orangebigmario-sprite
  greybigmario-sprite)

(define-sprites block-sheet 4 1 2
  blueblock-sprite
  orangeblock-sprite
  greyblock-sprite)

(define-sprites blooper-sheet 4 2 2
  blueblooper-sprite
  orangeblooper-sprite
  greyblooper-sprite)

(define-sprites bowser-sheet 4 4 2
  bluebowser-sprite
  orangebowser-sprite
  greybowser-sprite)

(define-sprites brick-sheet 4 1 2
  bluebrick-sprite
  orangebrick-sprite
  greybrick-sprite)

(define-sprites buzzy-sheet 4 2 2
  bluebuzzy-sprite
  orangebuzzy-sprite
  greybuzzy-sprite)

(define-sprites cheep-sheet 4 2 2
  bluecheep-sprite
  orangecheep-sprite
  greycheep-sprite)

(define-sprites fence-sheet 4 1 2
  bluefence-sprite
  orangefence-sprite
  greyfence-sprite)

(define-sprites goomba-sheet 4 2 2
  bluegoomba-sprite
  orangegoomba-sprite
  greygoomba-sprite)

(define-sprites lakitu-sheet 4 2 2
  bluelakitu-sprite
  orangelakitu-sprite
  greylakitu-sprite)

(define-sprites paratroopa-sheet 4 2 2
  blueparatroopa-sprite
  orangeparatroopa-sprite
  greyparatroopa-sprite)

(define-sprites pipe-sheet 4 1 2
  bluepipe-sprite
  orangepipe-sprite
  greypipe-sprite)

(define-sprites piranha-sheet 4 5 2
  bluepiranha-sprite
  orangepiranha-sprite
  greypiranha-sprite)

(define-sprites question-sheet 4 1 2
  bluequestion-sprite
  orangequestion-sprite
  greyquestion-sprite)

(define-sprites smallmario-sheet 4 4 2
  bluesmallmario-sprite
  orangesmallmario-sprite
  greysmallmario-sprite)

(define-sprites spiny-sheet 4 2 2
  bluespiny-sprite
  orangespiny-sprite
  greyspiny-sprite)

(define-sprites troopa-sheet 4 2 2
  bluetroopa-sprite
  orangetroopa-sprite
  greytroopa-sprite)

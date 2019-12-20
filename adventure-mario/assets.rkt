#lang at-exp racket

(require fandom-sprites/assets-mario
         adventure)

(provide redmushroom-sprite
         greenmushroom-sprite)

(define (easy-sprite sheet r c n)
  (sheet->sprite sheet
                 #:rows r
                 #:columns c
                 #:row-number n
                 #:delay 5))

(define-syntax-rule (define-sprite sheet r c n sprite-name)
  (begin
    (provide sprite-name)
    (define sprite-name (easy-sprite sheet r c n))))

(define-sprite bigmario-sheet 4 4 1 bigmario-sprite)
(define-sprite block-sheet 4 1 1 pinkblock-sprite)
(define-sprite blooper-sheet 4 2 1 blooper-sprite)
(define-sprite bowser-sheet 4 4 1 bowser-sprite)
(define-sprite brick-sheet 4 1 1 pinkbrick-sprite)
(define-sprite buzzy-sheet 4 2 1 buzzy-sprite)
(define-sprite cheep-sheet 4 2 1 cheep-sprite)
(define-sprite fence-sheet 4 1 1 pinkfence-sprite)
(define-sprite goomba-sheet 4 2 1 goomba-sprite)
(define-sprite lakitu-sheet 4 2 1 lakitu-sprite)
(define-sprite paratroopa-sheet 4 2 1 paratroopa-sprite)
(define-sprite pipe-sheet 4 1 1 pinkpipe-sprite)
(define-sprite piranha-sheet 4 5 1 piranha-sprite)
(define-sprite question-sheet 4 1 1 pinkquestion-sprite)
(define-sprite smallmario-sheet 4 4 1 smallmario-sprite)
(define-sprite spiny-sheet 4 2 1 spiny-sprite)
(define-sprite troopa-sheet 4 2 1 troopa-sprite)


(define-sprite princesspeach-sheet 1 2 1 princesspeach-sprite)
(define-sprite toad-sheet 1 2 1 toad-sprite)
(define-sprite luigi-sheet 1 2 1 luigi-sprite)
(define-sprite mario-sheet 1 2 1 mario-sprite)
(define-sprite yoshi-sheet 2 2 1 yoshi-sprite)
(define-sprite yoshi-sheet 2 2 2 redyoshi-sprite)



(define-syntax-rule (define-sprites sheet r c start sprite-name ...)
  (begin
    (define row-num (sub1 start))
    (define (next-row-num)
      (begin
        (set! row-num (add1 row-num))
        row-num))
    (provide sprite-name ...)
    (define sprite-name (easy-sprite sheet r c (next-row-num))) ...))

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


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

         ;define-sprite
         ;define-sprites
         )

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
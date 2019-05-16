#lang at-exp racket

(require ts-kata-util/assets/main
         adventure)

(define-assets-from "assets")

(provide princesspeach-sprite        
         toad-sprite
         luigi-sprite
         mario-sprite
         yoshi1-sprite
         yoshi2-sprite
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
  bigmario1-sprite
  bigmario2-sprite
  bigmario3-sprite
  bigmario4-sprite)

(define-sprite block-sheet 4 1
  block1-sprite
  block2-sprite
  block3-sprite
  block4-sprite)

(define-sprite blooper-sheet 4 2
  blooper1-sprite
  blooper2-sprite
  blooper3-sprite
  blooper4-sprite)

(define-sprite bowser-sheet 4 4
  bowser1-sprite
  bowser2-sprite
  bowser3-sprite
  bowser4-sprite)

(define-sprite brick-sheet 4 1
  brick1-sprite
  brick2-sprite
  brick3-sprite
  brick4-sprite)

(define-sprite buzzy-sheet 4 2
  buzzy1-sprite
  buzzy2-sprite
  buzzy3-sprite
  buzzy4-sprite)

(define-sprite cheep-sheet 4 2
  cheep1-sprite
  cheep2-sprite
  cheep3-sprite
  cheep4-sprite)

(define-sprite fence-sheet 4 1
  fence1-sprite
  fence2-sprite
  fence3-sprite
  fence4-sprite)

(define-sprite goomba-sheet 4 2
  goomba1-sprite
  goomba2-sprite
  goomba3-sprite
  goomba4-sprite)

(define-sprite lakitu-sheet 4 2
  lakitu1-sprite
  lakitu2-sprite
  lakitu3-sprite
  lakitu4-sprite)

(define-sprite paratroopa-sheet 4 2
  paratroopa1-sprite
  paratroopa2-sprite
  paratroopa3-sprite
  paratroopa4-sprite)

(define-sprite pipe-sheet 4 1
  pipe1-sprite
  pipe2-sprite
  pipe3-sprite
  pipe4-sprite)

(define-sprite piranha-sheet 4 5
  piranha1-sprite
  piranha2-sprite
  piranha3-sprite
  piranha4-sprite)

(define-sprite question-sheet 4 1
  question1-sprite
  question2-sprite
  question3-sprite
  question4-sprite)

(define-sprite smallmario-sheet 4 4
  smallmario1-sprite
  smallmario2-sprite
  smallmario3-sprite
  smallmario4-sprite)

(define-sprite spiny-sheet 4 2
  spiny1-sprite
  spiny2-sprite
  spiny3-sprite
  spiny4-sprite)

(define-sprite troopa-sheet 4 2
  troopa1-sprite
  troopa2-sprite
  troopa3-sprite
  troopa4-sprite)

(define princesspeach-sprite
  (easy-sprite princesspeach-sheet 1 2 1))

(define toad-sprite
  (easy-sprite toad-sheet 1 2 1))

(define luigi-sprite
  (easy-sprite luigi-sheet 1 2 1))

(define mario-sprite
  (easy-sprite mario-sheet 1 2 1))

(define yoshi1-sprite
  (easy-sprite yoshi-sheet 2 2 1))

(define yoshi2-sprite
  (easy-sprite yoshi-sheet 2 2 2))

(define redmushroom-sprite
  (easy-sprite redmushroom-sheet 1 1 1))

(define greenmushroom-sprite
  (easy-sprite greenmushroom-sheet 1 1 1))
#lang at-exp racket

(require ts-kata-util/assets/main
         survival)

(define-assets-from "assets")

(provide armoredmewtwo-sprite
         pikachu-sprite
         pikachurun-sprite

         bulbasaur-sprite
         ivysaur-sprite
         venasaur-sprite
         squirtle-sprite
         wartortle-sprite
         blastoise-sprite
         charmander-sprite
         charmelon-sprite
         charizard-sprite
         
         jessie-sprite
         james-sprite

         redboy-sprite
         redgirl-sprite
         greenboy-sprite
         greengirl-sprite
         
         )

(define armoredmewtwo-sprite
  (sheet->sprite armoredmewtwo-sheet
               #:rows 4
               #:columns 4
               #:row-number 3
               #:delay 5))

(define pikachu-sprite
  (sheet->sprite pikachu-sheet
               #:rows 1
               #:columns 4
               #:row-number 1
               #:delay 5))

(define pikachurun-sprite
  (sheet->sprite pikachurun-sheet
               #:rows 1
               #:columns 4
               #:row-number 1
               #:delay 5))

(define jessie-sprite
  (sheet->sprite jessie-sheet
               #:rows 4
               #:columns 4
               #:row-number 3
               #:delay 5))

(define james-sprite
  (sheet->sprite james-sheet
               #:rows 4
               #:columns 4
               #:row-number 3
               #:delay 5))

(define redboy-sprite
  (sheet->sprite redboy-sheet
               #:rows 4
               #:columns 4
               #:row-number 3
               #:delay 5))

(define redgirl-sprite
  (sheet->sprite redgirl-sheet
               #:rows 4
               #:columns 4
               #:row-number 3
               #:delay 5))

(define greenboy-sprite
  (sheet->sprite greenboy-sheet
               #:rows 4
               #:columns 4
               #:row-number 3
               #:delay 5))

(define greengirl-sprite
  (sheet->sprite greengirl-sheet
               #:rows 4
               #:columns 4
               #:row-number 3
               #:delay 5))


(define bulbasaur-sprite
  (sheet->sprite bulbasaur-sheet
               #:rows 1
               #:columns 5
               #:row-number 1
               #:delay 5))

(define ivysaur-sprite
  (sheet->sprite ivysaur-sheet
               #:rows 1
               #:columns 6
               #:row-number 1
               #:delay 5))

(define venasaur-sprite
  (sheet->sprite venusaur-sheet
               #:rows 1
               #:columns 5
               #:row-number 1
               #:delay 5))

(define squirtle-sprite
  (sheet->sprite squirtle-sheet
               #:rows 1
               #:columns 6
               #:row-number 1
               #:delay 5))

(define wartortle-sprite
  (sheet->sprite wartortle-sheet
               #:rows 1
               #:columns 8
               #:row-number 1
               #:delay 5))

(define blastoise-sprite
  (sheet->sprite blastoise-sheet
               #:rows 1
               #:columns 8
               #:row-number 1
               #:delay 5))

(define charmander-sprite
  (sheet->sprite charmander-sheet
               #:rows 1
               #:columns 5
               #:row-number 1
               #:delay 5))

(define charmelon-sprite
  (sheet->sprite charmeleon-sheet
               #:rows 1
               #:columns 8
               #:row-number 1
               #:delay 5))

(define charizard-sprite
  (sheet->sprite charizard-sheet
               #:rows 1
               #:columns 8
               #:row-number 1
               #:delay 5))

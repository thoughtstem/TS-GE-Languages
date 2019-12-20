#lang at-exp racket

(require  fandom-sprites/assets-pokemon
         survival)

(provide pokeball2-sheet
         dawnstone-sprite
         duskstone-sprite
         everstone-sprite
         firestone-sprite
         leafstone-sprite
         moonstone-sprite
         shinystone-sprite
         sunstone-sprite
         thunderstone-sprite
         waterstone-sprite
         dawnstone-sprite
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

(define-sprite armoredmewtwo-sheet 4 4 3 armoredmewtwo-sprite)
(define-sprite pikachu-sheet 1 4 1 pikachu-sprite)
(define-sprite pikachurun-sheet 1 4 1 pikachurun-sprite)
(define-sprite jessie-sheet 4 4 3 jessie-sprite)
(define-sprite james-sheet 4 4 3 james-sprite)
(define-sprite redboy-sheet 4 4 3 redboy-sprite)
(define-sprite redgirl-sheet 4 4 3 redgirl-sprite)
(define-sprite greenboy-sheet 4 4 3 greenboy-sprite)
(define-sprite greengirl-sheet 4 4 3 greengirl-sprite)
(define-sprite bulbasaur-sheet 1 5 1 bulbasaur-sprite)
(define-sprite ivysaur-sheet 1 6 1 ivysaur-sprite)
(define-sprite venusaur-sheet 1 5 1 venasaur-sprite)
(define-sprite squirtle-sheet 1 6 1 squirtle-sprite)
(define-sprite wartortle-sheet 1 8 1 wartortle-sprite)
(define-sprite blastoise-sheet 1 8 1 blastoise-sprite)
(define-sprite charmander-sheet 1 5 1 charmander-sprite)
(define-sprite charmeleon-sheet 1 8 1 charmelon-sprite)
(define-sprite charizard-sheet 1 8 1 charizard-sprite)


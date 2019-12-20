#lang at-exp racket

(require fandom-sprites/assets-harrypotter
         adventure)

(provide potion-sprite)

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

(define-sprite harrypotter-sheet 1 18 1 harrypotter-sprite)
(define-sprite flyingbook-sheet 1 6 1  flyingbook-sprite)
(define-sprite pumpkin-sheet 1 8 1 pumpkin-sprite)
(define-sprite cauldron-sheet 1 6 1 magiccauldron-sprite)
(define-sprite snape-sheet 1 21 1 snape-sprite)
(define-sprite tentacula-sheet 1 14 1 tentacula-sprite)
(define-sprite hagrid-sheet 1 11 1 hagrid-sprite)
(define-sprite oldwizard-sheet 1 6 1 oldwizard-sprite)
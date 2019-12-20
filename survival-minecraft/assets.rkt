#lang at-exp racket

(require fandom-sprites/assets-minecraft
         game-engine)


(provide ore-entity
         coalore-sprite
         ironore-sprite
         copperore-sprite
         goldore-sprite
         meseore-sprite
         diamondore-sprite
         coallump-sprite
         ironlump-sprite
         copperlump-sprite
         goldingot-sprite
         mesecrystal-sprite
         diamond-sprite
         fireball-sheet)

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

(define-sprite steve-sheet 1 2 1 steve-sprite)
(define-sprite alex-sheet 1 2 1 alex-sprite)
(define-sprite (scale .75 creeper-sheet)1 4 1 creeper-sprite)
(define-sprite chicken-sheet 1 4 1 chicken-sprite)
(define-sprite pig-sheet 1 4 1 pig-sprite)
(define-sprite sheep-sheet 1 4 1 sheep-sprite)
(define-sprite (scale .75 skeleton-sheet) 1 4 1 skeleton-sprite)
(define-sprite ghast-sheet 1 4 1 ghast-sprite)

(define (ore-entity)
  (sprite->entity (sheet->sprite ironore-sprite #:columns 1)
                  #:position   (posn 0 0)
                  #:name       "Iron Ore"
                  #:components (active-on-bg 0)
                               (physical-collider)))
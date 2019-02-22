#lang at-exp racket

(require ts-kata-util/assets/main
         game-engine)

(define-assets-from "assets")

(provide steve-sprite
         alex-sprite

         chicken-sprite
         pig-sprite
         sheep-sprite
         
         creeper-sprite
         skeleton-sprite
         ghast-sprite
         
         ore-entity)


(define steve-sprite
  (row->sprite steve-sheet
                 #:columns 2
                 #:delay   3 ))

(define alex-sprite
  (row->sprite alex-sheet
                 #:columns 2
                 #:delay   3 ))

(define creeper-sprite
  (row->sprite (scale .75 creeper-sheet)
               #:columns 4
               #:delay 4))

(define chicken-sprite
  (row->sprite chicken-sheet
               #:columns 4
               #:delay 4))

(define pig-sprite
  (row->sprite pig-sheet
               #:columns 4
               #:delay 4))

(define sheep-sprite
  (row->sprite sheep-sheet
               #:columns 4
               #:delay 4))

(define (ore-entity)
  (sprite->entity (sheet->sprite ironore-sprite #:columns 1)
                  #:position   (posn 0 0)
                  #:name       "Iron Ore"
                  #:components (active-on-bg 0)
                               (physical-collider)))

(define skeleton-sprite
  (row->sprite (scale .75 skeleton-sheet)
               #:columns 4
               #:delay 3))

(define ghast-sprite
  (row->sprite ghast-sheet
               #:columns 4
               #:delay 6))


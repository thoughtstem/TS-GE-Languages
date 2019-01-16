#lang starwars-battle-arena
(define (my-paint)
 (paint #:damage     10
        #:durability 20
        #:sprite     paint-sprite
        #:speed      3
        #:range      15))

(define (my-weapon-3)
 (custom-weapon #:name   "Paint Thrower"
                #:sprite STUDENT-IMAGE-HERE
                #:dart   (my-paint)
                #:rarity 'epic))

(starwars-game
#:weapon-list (list (my-weapon-3)))

#lang battle-arena-starwars
(define (my-weapon-3)
 (custom-weapon #:name   "Paint Thrower"
                #:sprite PAINT-THROWER-ICON
                #:dart   (paint)
                #:rarity 'epic))

(starwars-game
#:weapon-list (list (my-weapon-3)))


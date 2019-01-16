#lang starwars-battle-arena
(define (my-spear)
 (spear #:damage     25
        #:durability 10
        #:sprite     spear-sprite
        #:speed      5
        #:range      20))

(define (my-weapon-1)
 (custom-weapon #:name   "Spear"
                #:sprite STUDENT-IMAGE-HERE
                #:dart   (my-spear)
                #:rarity 'common))

(starwars-game
#:weapon-list (list (my-weapon-1)))


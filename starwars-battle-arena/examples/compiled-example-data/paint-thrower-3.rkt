#lang battle-arena
(define (my-paint)
 (paint #:damage     10
        #:durability 20))

(define (my-weapon-3)
 (custom-weapon #:name   "Paint Thrower"
                #:sprite STUDENT-IMAGE-HERE
                #:dart   (my-paint)
                #:rarity 'epic))

(battle-arena-game
#:weapon-list (list (my-weapon-3)))


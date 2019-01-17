#lang battle-arena-starwars
(define (my-sword)
 (sword #:damage     50
        #:durability 20
        #:sprite     STUDENT-IMAGE-HERE
        #:speed      0
        #:range      10))

(define (my-weapon-2)
 (custom-weapon #:name   "Sword"
                #:sprite STUDENT-IMAGE-HERE
                #:dart   (my-sword)))

(starwars-game
#:weapon-list (list (my-weapon-2)))


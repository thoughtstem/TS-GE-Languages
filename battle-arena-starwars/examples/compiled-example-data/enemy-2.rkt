#lang battle-arena-starwars
(define (my-enemy)
 (custom-enemy #:ai              'easy
               #:health          200
               #:shield          100
               #:amount-in-world 10))

(starwars-game
#:enemy-list (list (my-enemy)))


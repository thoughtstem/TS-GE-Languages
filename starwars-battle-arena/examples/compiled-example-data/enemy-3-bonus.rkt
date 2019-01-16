#lang battle-arena
(define (my-enemy)
 (custom-enemy #:sprite          (sheet->sprite STUDENT-IMAGE-HERE
                                                #:columns 4)
               #:ai              'easy
               #:health          200
               #:shield          100
               #:amount-in-world 10))

(battle-arena-game
#:enemy-list (list (my-enemy)))


#lang battle-arena-starwars
(define (my-avatar)
 (custom-jedi #:sprite (sheet->sprite STUDENT-IMAGE-HERE
                                        #:columns 3)))

(starwars-game
#:avatar (my-avatar))


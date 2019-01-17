#lang battle-arena-starwars
(define (my-avatar)
 (custom-jedi #:sprite     STUDENT-IMAGE-HERE
                #:key-mode   'wasd
                #:mouse-aim? #t))

(starwars-game
#:avatar (my-avatar))


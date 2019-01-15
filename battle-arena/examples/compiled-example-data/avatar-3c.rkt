#lang battle-arena
(define (my-avatar)
 (custom-avatar #:sprite     STUDENT-IMAGE-HERE
                #:key-mode   'wasd
                #:mouse-aim? #t))

(battle-arena-game
#:avatar (my-avatar))

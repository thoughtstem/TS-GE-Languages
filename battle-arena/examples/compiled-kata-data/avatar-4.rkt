#lang battle-arena
(define (my-avatar)
 (custom-avatar #:sprite (sheet->sprite STUDENT-IMAGE-HERE
                                        #:columns 4)
                #:key-mode   'wasd
                #:mouse-aim? #t))

(battle-arena-game
#:avatar (my-avatar))

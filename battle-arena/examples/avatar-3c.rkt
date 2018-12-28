#lang battle-arena

(define-kata-code battle-arena avatar-3c

  (define (my-avatar)
    (custom-avatar #:sprite     STUDENT-IMAGE-HERE
                   #:key-mode   'wasd
                   #:mouse-aim? #t))
  
  (battle-arena-game
   #:avatar (my-avatar)))

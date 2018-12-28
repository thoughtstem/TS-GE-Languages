#lang battle-arena

(define-kata-code battle-arena avatar-3

  (define (my-avatar)
    (custom-avatar #:sprite STUDENT-IMAGE-HERE))
  
  (battle-arena-game
   #:avatar (my-avatar)))

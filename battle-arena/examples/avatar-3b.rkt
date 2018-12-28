#lang battle-arena

(define-kata-code battle-arena avatar-3b

  (define (my-avatar)
    (custom-avatar #:sprite (sheet->sprite STUDENT-IMAGE-HERE
                                           #:columns 3)))
  
  (battle-arena-game
   #:avatar (my-avatar)))

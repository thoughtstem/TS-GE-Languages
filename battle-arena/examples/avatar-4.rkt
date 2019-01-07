#lang racket
(require ts-kata-util battle-arena)


(define-kata-code battle-arena avatar-4
  
  (define (my-avatar)
    (custom-avatar #:sprite (sheet->sprite STUDENT-IMAGE-HERE
                                           #:columns 4)))
   
  (battle-arena-game
   #:avatar (my-avatar))
  )

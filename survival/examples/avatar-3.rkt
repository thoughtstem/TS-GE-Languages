#lang survival
 
(define-kata-code survival avatar-3

  (define (my-avatar)
    (custom-avatar #:sprite bat-sprite))
  
 (survival-game
   #:avatar (my-avatar)))

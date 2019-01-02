#lang survival
 
(define-kata-code survival avatar-2

  (define (my-avatar)
    (custom-avatar #:sprite (star 30 'solid 'yellow)))
  
 (survival-game
   #:avatar (my-avatar)))

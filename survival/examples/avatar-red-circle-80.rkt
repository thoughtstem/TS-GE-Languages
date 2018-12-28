#lang survival
 
(define-kata-code survival basic-avatar
 (define (my-avatar)
   (custom-avatar #:sprite (circle 40 "solid" "red")))

 (survival-game
   #:avatar (my-avatar)))

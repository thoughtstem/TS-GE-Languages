#lang survival
 
(define-kata-code survival basic-avatar
 (define (my-avatar)
   (custom-avatar #:sprite (circle 20 "solid" "red")))

 (survival-game
   #:avatar (my-avatar)))

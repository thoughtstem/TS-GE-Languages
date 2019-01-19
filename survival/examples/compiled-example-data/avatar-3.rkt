#lang survival
(define (my-avatar)
 (custom-avatar #:sprite bat-sprite))

(survival-game
 #:avatar (my-avatar))

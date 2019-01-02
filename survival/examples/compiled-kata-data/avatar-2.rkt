#lang survival
(define (my-avatar)
 (custom-avatar #:sprite (star 30 'solid 'yellow)))

(survival-game
 #:avatar (my-avatar))

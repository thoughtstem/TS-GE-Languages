#lang racket

(require ts-kata-util survival)
 
(define-kata-code survival food-2
  (define (my-food)
    (custom-food #:amount-in-world 2
                 #:heals-by        20))
 
  (survival-game
   #:avatar     (custom-avatar)
   #:food-list  (list (my-food))))
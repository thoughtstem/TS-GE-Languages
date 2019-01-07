#lang survival
 
(define-kata-code survival food-3

  (define (my-food)
    (custom-food #:sprite          apples-sprite
                 #:name            "Apples"
                 #:amount-in-world 2
                 #:heals-by        20))

  (survival-game
   #:avatar     (custom-avatar)
   #:coin-list  (list (custom-coin))
   #:food-list  (list (my-food))))

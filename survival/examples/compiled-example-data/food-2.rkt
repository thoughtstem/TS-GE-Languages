#lang survival
(define (my-food)
 (custom-food #:amount-in-world 2
              #:heals-by        20))

(survival-game
#:avatar     (custom-avatar)
#:food-list  (list (my-food)))

#lang survival
 
(define-kata-code survival food-1

  (survival-game
   #:avatar     (custom-avatar)
   #:coin-list  (list (custom-coin))
   #:food-list  (list (custom-food #:amount-in-world 10))))
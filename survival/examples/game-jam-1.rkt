#lang survival
 
(define-kata-code survival game-jam-1
(survival-game
  #:avatar       (custom-avatar)
  #:coin-list    (list (custom-coin))
  #:food-list    (list (custom-food #:amount-in-world 10))
  ;#:enemy-list   (list (custom-enemy))
  #:crafter-list (list (custom-crafter))))
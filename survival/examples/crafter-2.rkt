#lang survival
 
(define-kata-code survival crafter-2
  (define (carrot-cake)
    (custom-food #:sprite          (rectangle 40 20 "solid" "brown")
                 #:name            "Carrot Cake"
                 #:heals-by        25
                 #:amount-in-world 1))

  (survival-game
   #:avatar       (custom-avatar)
   #:coin-list    (list (custom-coin))
   #:food-list    (list (custom-food #:amount-in-world 10)
                        (carrot-cake))
   ;#:enemy-list   (list (custom-enemy))
   #:crafter-list (list (custom-crafter))))
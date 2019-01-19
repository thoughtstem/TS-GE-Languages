#lang survival
(define (carrot-cake)
 (custom-food #:sprite          (rectangle 40 20 "solid" "brown")
              #:name            "Carrot Cake"
              #:heals-by        25
              #:amount-in-world 1))

(survival-game
#:avatar       (custom-avatar)
#:food-list    (list (custom-food #:amount-in-world 10)
                     (carrot-cake))
#:crafter-list (list (custom-crafter)))

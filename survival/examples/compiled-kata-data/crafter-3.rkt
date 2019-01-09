#lang survival
(define (carrot-cake)
 (custom-food #:sprite   (rectangle 40 20 "solid" "brown")
              #:name     "Carrot Cake"
              #:heals-by 25))

(define carrot-cake-recipe
 (recipe #:product     (carrot-cake)
         #:build-time  5
         #:ingredients (list "Carrot")))

(define (my-oven)
 (custom-crafter #:menu (crafting-menu-set! #:recipes carrot-cake-recipe)))

(survival-game
#:avatar       (custom-avatar)
#:food-list    (list (custom-food #:amount-in-world 10)
                     (carrot-cake))
#:crafter-list (list (my-oven)))

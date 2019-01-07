#lang survival
 
(define-kata-code survival crafter-4
  (define (carrot-cake)
    (custom-food #:sprite   (rectangle 40 20 "solid" "brown")
                 #:name     "Carrot Cake"
                 #:heals-by 25))

  (define carrot-cake-recipe
    (recipe #:product     (carrot-cake)
            #:build-time  5
            #:ingredients (list "Carrot")
            ))

  (define (carrot-cupcake)
    (custom-food #:sprite   (square 10 "solid" "brown")
                 #:name     "Carrot Cupcake"
                 #:heals-by 15))

  (define carrot-cupcake-recipe
    (recipe #:product     (carrot-cupcake)
            #:build-time  10
            #:ingredients (list "Carrot Cake")
            ))

  (define (my-oven)
    (custom-crafter #:menu (crafting-menu-set! #:recipes carrot-cake-recipe
                                               carrot-cupcake-recipe))) 

  (survival-game
   #:avatar       (custom-avatar)
   #:coin-list    (list (custom-coin))
   #:food-list    (list (custom-food #:amount-in-world 10)
                        (carrot-cake))
   ;#:enemy-list   (list (custom-enemy))
   #:crafter-list (list (my-oven))))
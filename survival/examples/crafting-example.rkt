#lang survival

(require ts-kata-util survival)

(define-kata-code survival crafting-example
  
  (define (red-curry)
    (custom-food #:name "Red Curry"
                 #:sprite carrot-stew-sprite
                 #:respawn? #f
                 #:heals-by 50))

  (define (green-curry)
    (custom-food #:name "Green Curry"
                 #:sprite fish-stew-sprite
                 #:respawn? #f
                 #:heals-by 50))

  (define red-curry-recipe
    (recipe #:product (red-curry)
            #:build-time 40
            #:ingredients (list "Carrot")))

  (define green-curry-recipe
    (recipe #:product (green-curry)
            #:build-time 40
            #:ingredients (list "Carrot")))

  (survival-game
   #:avatar       (custom-avatar #:sprite (random-character-sprite))
   #:food-list    (list (custom-food #:name "Carrot"
                                     #:amount-in-world 10
                                     #:heals-by 20)
                        (red-curry)
                        (green-curry))
   #:crafter-list (list (custom-crafter #:sprite cauldron-sprite
                                        #:recipe-list (list red-curry-recipe
                                                            green-curry-recipe))
                        ))
  )



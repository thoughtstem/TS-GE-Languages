#lang survival

(require ts-kata-util survival)

(define-kata-code survival crafting-example-simple
  
  (survival-game
   #:avatar       (custom-avatar)
   #:food-list    (list (carrot #:amount-in-world 10)
                        (carrot-stew))
   #:crafter-list (list (custom-crafter
                         #:recipe-list (list carrot-stew-recipe))))
  )



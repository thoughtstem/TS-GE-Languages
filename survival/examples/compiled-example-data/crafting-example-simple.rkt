#lang survival
(survival-game
#:avatar       (custom-avatar)
#:food-list    (list (carrot #:amount-in-world 10)
                     (carrot-stew))
#:crafter-list (list (custom-crafter
                      #:recipe-list (list carrot-stew-recipe))))

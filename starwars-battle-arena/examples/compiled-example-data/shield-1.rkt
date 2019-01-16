#lang starwars-battle-arena
(starwars-game
#:item-list (list (custom-item #:name     "Shield Potion"
                               #:sprite   (make-icon "SP" 'blue 'white)
                               #:on-use   (change-shield-by 50))))


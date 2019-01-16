#lang battle-arena
(battle-arena-game
#:item-list (list (custom-item #:name     "Shield Potion"
                               #:sprite   (make-icon "SP" 'blue 'white)
                               #:on-use   (change-shield-by 50))))


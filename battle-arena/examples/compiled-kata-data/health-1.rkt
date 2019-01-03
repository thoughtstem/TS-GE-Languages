#lang battle-arena
(battle-arena-game
#:item-list (list (custom-item #:name     "Health Potion"
                               #:sprite   (make-icon "HP" 'green 'white)
                               #:on-use   (change-health-by 50))))

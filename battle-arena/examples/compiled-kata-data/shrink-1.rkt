#lang battle-arena
(battle-arena-game
#:item-list (list (custom-item #:name   "Shrink Potion"
                               #:sprite (make-icon "SML" 'blue 'white)
                               #:on-use (scale-sprite 0.5 #:for 100))))

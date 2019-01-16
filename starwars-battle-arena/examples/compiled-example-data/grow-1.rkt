#lang battle-arena
(battle-arena-game
#:item-list (list (custom-item #:name   "Grow Potion"
                               #:sprite (make-icon "BIG" 'red 'white)
                               #:on-use (scale-sprite 2 #:for 100))))


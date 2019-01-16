#lang battle-arena
(battle-arena-game
#:item-list (list (custom-item #:name     "Max Shield Potion"
                               #:sprite   (make-icon "MSP" 'blue 'white)
                               #:on-use   (set-shield-to 100))))


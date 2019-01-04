#lang battle-arena
(battle-arena-game
#:item-list (list (custom-item #:name   "Max Health Potion"
                               #:sprite (make-icon "MHP" 'green 'white)
                               #:on-use (set-health-to 100))))

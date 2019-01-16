#lang starwars-battle-arena
(starwars-game
#:item-list (list (custom-item #:name   "Health Potion"
                               #:sprite (make-icon "HP" 'green 'white)
                               #:on-use (change-health-by 50))))


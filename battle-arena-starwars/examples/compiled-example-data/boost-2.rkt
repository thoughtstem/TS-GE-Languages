#lang battle-arena-starwars
(starwars-game
#:item-list (list (custom-item #:name   "Speed Boost"
                               #:sprite (make-icon "SB" 'yellow)
                               #:on-use (multiply-speed-by 2 #:for 200))))


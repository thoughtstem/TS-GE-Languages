#lang battle-arena
(define (damage-boost)
 (custom-item #:name   "Damage Boost"
              #:sprite (make-icon "DB" 'orangered)
              #:on-use (change-damage-by 1000 #:for 200)
              #:rarity 'epic))

(define (speed-boost)
 (custom-item #:name   "Speed Boost"
              #:sprite (make-icon "SB" 'yellow)
              #:on-use (multiply-speed-by 2 #:for 200)
              #:rarity 'uncommon))

(battle-arena-game
#:item-list (list (damage-boost)
                  (speed-boost)))

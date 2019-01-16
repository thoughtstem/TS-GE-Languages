#lang starwars-battle-arena
(define (shield-potion)
 (custom-item #:name     "Shield Potion"
              #:sprite   (make-icon "SP" 'blue 'white)
              #:on-use   (change-shield-by 50)
              #:rarity   'uncommon
              #:respawn? #t))

(define (max-shield)
 (custom-item #:name     "Max Shield Potion"
              #:sprite   (make-icon "MSP" 'blue 'white)
              #:on-use   (set-shield-to 100)
              #:rarity   'epic))

(starwars-game
#:item-list (list (shield-potion)
                  (max-shield)))


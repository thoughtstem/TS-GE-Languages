#lang battle-arena-starwars
(define (my-weapon-1)
 (custom-weapon #:name              "Spear"
                #:sprite            SPEAR-ICON
                #:dart              (spear)
                #:rarity            'common
                #:mouse-fire-button 'left
                #:rapid-fire?       #f))

(starwars-game
#:weapon-list (list (my-weapon-1)))


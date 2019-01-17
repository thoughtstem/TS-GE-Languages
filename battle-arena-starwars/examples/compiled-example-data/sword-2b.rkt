#lang battle-arena-starwars
(define (my-weapon-2)
 (custom-weapon #:name              "Sword"
                #:sprite            SWORD-ICON
                #:dart              (sword)
                #:rarity            'rare
                #:mouse-fire-button 'left
                #:rapid-fire?        #f))

(starwars-game
#:weapon-list (list (my-weapon-2)))


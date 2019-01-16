#lang starwars-battle-arena
(define (my-weapon-3)
 (custom-weapon #:name              "Paint Thrower"
                #:sprite            PAINT-THROWER-ICON
                #:dart              (paint)
                #:rarity            'epic
                #:fire-rate         30
                #:mouse-fire-button 'left))

(starwars-game
#:weapon-list (list (my-weapon-3)))


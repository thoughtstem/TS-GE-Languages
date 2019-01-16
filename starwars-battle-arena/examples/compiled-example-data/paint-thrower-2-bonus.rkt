#lang battle-arena
(define (my-weapon-3)
 (custom-weapon #:name              "Paint Thrower"
                #:sprite            PAINT-THROWER-ICON
                #:dart              (paint)
                #:rarity            'epic
                #:fire-rate         30
                #:mouse-fire-button 'left))

(battle-arena-game
#:weapon-list (list (my-weapon-3)))


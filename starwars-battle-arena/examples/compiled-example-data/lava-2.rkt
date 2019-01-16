#lang starwars-battle-arena
(starwars-game
#:weapon-list (list (custom-weapon
                     #:name "Lava Pit"
                     #:sprite (make-icon "LP" 'red)
                     #:dart (lava-builder
                             #:damage 25
                             #:size   2))))


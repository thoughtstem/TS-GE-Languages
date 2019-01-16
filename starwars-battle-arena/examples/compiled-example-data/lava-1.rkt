#lang starwars-battle-arena
(starwars-game
#:weapon-list (list (custom-weapon
                     #:name "Lava Pit"
                     #:sprite (make-icon "LP")
                     #:dart (lava-builder))))


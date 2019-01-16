#lang starwars-battle-arena
(starwars-game
#:weapon-list (list (custom-weapon
                     #:name "Spear Tower"
                     #:sprite (make-icon "ST")
                     #:dart (spear-tower-builder))))


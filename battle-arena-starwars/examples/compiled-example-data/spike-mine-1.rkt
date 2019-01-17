#lang battle-arena-starwars
(starwars-game
#:weapon-list (list (custom-weapon
                     #:name "Spike Mine"
                     #:sprite (make-icon "SM")
                     #:dart (spike-mine-builder))))


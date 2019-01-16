#lang starwars-battle-arena
(starwars-game
#:weapon-list (list (custom-weapon
                     #:name "Lava Pit"
                     #:sprite (make-icon "LP" 'red 'white)
                     #:dart (lava-builder
                             #:damage  25
                             #:size    1
                             #:sprite  (square 10 'solid 'black)
                             #:range   10))))


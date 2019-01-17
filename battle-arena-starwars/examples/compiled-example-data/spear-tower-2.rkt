#lang battle-arena-starwars
(starwars-game
#:weapon-list (list (custom-weapon
                     #:name "ST"
                     #:sprite (make-icon "ST" 'tan)
                     #:dart (spear-tower-builder
                             #:speed 10
                             #:range 50))))


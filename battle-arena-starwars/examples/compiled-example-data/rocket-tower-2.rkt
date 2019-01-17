#lang battle-arena-starwars
(starwars-game
#:weapon-list (list (custom-weapon
                     #:name "Rocket Tower"
                     #:sprite (make-icon "RT")
                     #:dart (rocket-tower-builder
                             #:speed      2
                             #:fire-mode  'homing))))


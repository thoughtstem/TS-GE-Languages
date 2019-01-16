#lang starwars-battle-arena
(starwars-game
#:weapon-list (list (custom-weapon
                     #:name "Repeater Tower"
                     #:sprite (make-icon "RT")
                     #:dart (repeater-tower-builder
                             #:speed      2
                             #:fire-rate  10))))


#lang battle-arena
(battle-arena-game
#:weapon-list (list (custom-weapon
                     #:name "Rocket Tower"
                     #:sprite (make-icon "RT")
                     #:dart (rocket-tower-builder
                             #:speed      2
                             #:fire-mode  'homing))))

#lang battle-arena
(battle-arena-game
#:weapon-list (list (custom-weapon
                     #:name "Rocket Tower"
                     #:sprite (make-icon "RT")
                     #:dart (rocket-tower-builder
                             #:sprite     STUDENT-IMAGE-HERE
                             #:range      200
                             #:damage     1000
                             #:speed      2
                             #:fire-mode  'homing))))

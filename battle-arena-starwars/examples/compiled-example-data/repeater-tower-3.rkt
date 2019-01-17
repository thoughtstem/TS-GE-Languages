#lang battle-arena-starwars
(starwars-game
#:weapon-list (list (custom-weapon
                     #:name "Repeater Tower"
                     #:sprite (make-icon "RT")
                     #:dart (repeater-tower-builder
                             #:sprite     STUDENT-IMAGE-HERE
                             #:speed      15
                             #:damage     1000
                             #:range      500
                             #:fire-rate  0.1))))


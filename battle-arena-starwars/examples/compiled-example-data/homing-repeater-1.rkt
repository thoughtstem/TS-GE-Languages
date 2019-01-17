#lang battle-arena-starwars
(starwars-game
#:weapon-list    (list (custom-weapon #:name "Homing Repeater"
                                      #:sprite (make-icon "HR")
                                      #:fire-mode 'homing)))


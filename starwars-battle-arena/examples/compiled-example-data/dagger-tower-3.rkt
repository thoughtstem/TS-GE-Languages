#lang battle-arena
(battle-arena-game
#:weapon-list (list (custom-weapon
                     #:name "Dagger Tower"
                     #:sprite (make-icon "RT")
                     #:dart (dagger-tower-builder
                             #:sprite     STUDENT-IMAGE-HERE
                             #:damage     1000
                             #:speed      10
                             #:fire-mode  'spread))))


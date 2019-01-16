#lang starwars-battle-arena
(define (my-dart)
 (custom-dart
  #:damage 5
  #:speed  1
  #:range  200))

(define (my-weapon)
 (custom-weapon
  #:name      "Repeator"
  #:dart      (my-dart)))

(starwars-game
#:enemy-list (list (custom-enemy
                    #:weapon (my-weapon))))


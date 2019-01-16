#lang starwars-battle-arena
(define (my-weapon)
 (custom-weapon
  #:name      "Sword"
  #:dart      (sword #:damage 40)))

(starwars-game
#:enemy-list (list (custom-enemy
                    #:weapon (my-weapon))))


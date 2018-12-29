#lang battle-arena
(define (my-weapon)
 (custom-weapon
  #:name      "Sword"
  #:dart      (sword)
  #:fire-rate 10))

(battle-arena-game
#:enemy-list (list (custom-enemy
                    #:weapon (my-weapon))))

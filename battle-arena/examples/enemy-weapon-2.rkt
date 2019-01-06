#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena enemy-weapon-2
  
(define (my-weapon)
  (custom-weapon
   #:name      "Sword"
   #:dart      (sword #:damage 40)))

(battle-arena-game
 #:enemy-list (list (custom-enemy
                     #:weapon (my-weapon)))))

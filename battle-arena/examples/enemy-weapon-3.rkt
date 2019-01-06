#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena enemy-weapon-3
  
(define (my-dart)
  (custom-dart
   #:damage 5
   #:speed  1
   #:range  200))

(define (my-weapon)
  (custom-weapon
   #:name      "Repeator"
   #:dart      (my-dart)))

(battle-arena-game
 #:enemy-list (list (custom-enemy
                     #:weapon (my-weapon)))))

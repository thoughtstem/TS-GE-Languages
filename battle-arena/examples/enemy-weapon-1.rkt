#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena enemy-weapon-1
(battle-arena-game
 #:enemy-list (list (custom-enemy
                     #:weapon (custom-weapon
                               #:dart (sword))))))

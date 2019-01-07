#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena spear-tower-builder-1
  (battle-arena-game
   #:enemy-list  (list (custom-enemy #:amount-in-world 10))
   #:weapon-list (list (custom-weapon
                        #:dart (spike-mine-builder)))))



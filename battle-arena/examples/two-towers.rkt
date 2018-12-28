#lang battle-arena

(define-kata-code battle-arena spear-tower-builder-1
  (battle-arena-game
   #:enemy-list (list (custom-enemy #:amount-in-world 20))
   #:weapon-list (list (custom-weapon
                        #:dart (spear-tower-builder)))))



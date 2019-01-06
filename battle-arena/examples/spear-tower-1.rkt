#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena spear-tower-1
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Spear Tower"
                        #:sprite (make-icon "ST")
                        #:dart (spear-tower-builder)))))

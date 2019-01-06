#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena dagger-tower-1
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Dagger Tower"
                        #:sprite (make-icon "RT")
                        #:dart (dagger-tower-builder)))))

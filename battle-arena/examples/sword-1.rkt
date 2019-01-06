#lang racket
(require ts-kata-util battle-arena)


(define-kata-code battle-arena sword-1
  
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name    "Sword"
                                      #:sprite  SWORD-ICON
                                      #:dart    (sword)))))

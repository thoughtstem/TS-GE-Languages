#lang racket
(require ts-kata-util battle-arena)


(define-kata-code battle-arena sword-2
  (define (my-weapon-2)
    (custom-weapon #:name    "Sword"
                   #:sprite  SWORD-ICON
                   #:dart    (sword)
                   #:rarity  'rare))
  
  (battle-arena-game
   #:weapon-list (list (my-weapon-2))))

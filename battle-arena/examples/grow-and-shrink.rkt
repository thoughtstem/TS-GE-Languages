#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena grow-and-shrink

  (define (grow-potion)
    (custom-item #:name   "Grow Potion"
                 #:sprite (make-icon "BIG" 'red 'white)
                 #:on-use (scale-sprite 2 #:for 100)
                 #:rarity 'common))

  (define (shrink-potion)
    (custom-item #:name     "Shrink Potion"
                 #:sprite   (make-icon "SML" 'blue 'white)
                 #:on-use   (scale-sprite 0.5 #:for 100)
                 #:rarity   'rare))
  
  (battle-arena-game
   #:item-list      (list (grow-potion)
                          (shrink-potion))))

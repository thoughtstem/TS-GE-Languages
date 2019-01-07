#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena grow-1
  
  (battle-arena-game
   #:item-list (list (custom-item #:name   "Grow Potion"
                                  #:sprite (make-icon "BIG" 'red 'white)
                                  #:on-use (scale-sprite 2 #:for 100)))))

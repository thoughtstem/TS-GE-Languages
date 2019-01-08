#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena health-1
  
  (battle-arena-game
   #:item-list (list (custom-item #:name   "Health Potion"
                                  #:sprite (make-icon "HP" 'green 'white)
                                  #:on-use (change-health-by 50)))))
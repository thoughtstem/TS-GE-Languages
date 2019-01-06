#lang racket
(require ts-kata-util battle-arena)


(define-kata-code battle-arena shield-1
  (battle-arena-game
   #:item-list (list (custom-item #:name     "Shield Potion" 
                                  #:sprite   (make-icon "SP" 'blue 'white)
                                  #:on-use   (change-shield-by 50))))
  )


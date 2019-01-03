#lang battle-arena


(define-kata-code battle-arena boost-1
  (battle-arena-game
   #:item-list (list (custom-item #:name   "Damage Boost"
                                  #:sprite (make-icon "DB" 'orangered)
                                  #:on-use (change-damage-by 1000 #:for 200))))
  )


#lang battle-arena


(define-kata-code battle-arena paint-thrower-1
  
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name   "Paint Thrower"
                                      #:sprite PAINT-THROWER-ICON
                                      #:dart   (paint))))
  )

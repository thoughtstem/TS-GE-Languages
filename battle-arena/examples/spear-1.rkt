#lang battle-arena

(define-kata-code battle-arena spear-1
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name   "Spear"
                                      #:sprite SPEAR-ICON
                                      #:dart   (spear))))
  )

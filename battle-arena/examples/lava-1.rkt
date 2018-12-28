#lang battle-arena

(define-kata-code battle-arena lava-1
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Lava Pit"
                        #:sprite (make-icon "LP")
                        #:dart (lava-builder)))))

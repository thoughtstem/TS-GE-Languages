#lang battle-arena

(define-kata-code battle-arena rocket-tower-1
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Rocket Tower"
                        #:sprite (make-icon "RT")
                        #:dart (rocket-tower-builder)))))

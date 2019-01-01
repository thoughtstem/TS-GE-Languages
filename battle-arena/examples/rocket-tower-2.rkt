#lang battle-arena

(define-kata-code battle-arena rocket-tower-2
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Rocket Tower"
                        #:sprite (make-icon "RT")
                        #:dart (rocket-tower-builder
                                #:speed      2
                                #:fire-mode  'homing)))))

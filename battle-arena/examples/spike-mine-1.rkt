#lang battle-arena

(define-kata-code battle-arena spike-mine-1
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Spike Mine"
                        #:sprite (make-icon "SM")
                        #:dart (spike-mine-builder)))))

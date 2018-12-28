#lang battle-arena

(define-kata-code battle-arena spear-tower-2
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "ST"
                        #:sprite (make-icon "ST" 'tan)
                        #:dart (spear-tower-builder
                                #:speed 10 
                                #:range 50)))))

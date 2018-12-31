#lang battle-arena

(define-kata-code battle-arena repeater-tower-1
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Repeater Tower"
                        #:sprite (make-icon "RT")
                        #:dart (repeater-tower-builder)))))

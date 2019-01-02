#lang battle-arena

(define-kata-code battle-arena dagger-tower-2
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Dagger Tower"
                        #:sprite (make-icon "RT")
                        #:dart (dagger-tower-builder
                                #:speed      10
                                #:fire-mode  'spread)))))
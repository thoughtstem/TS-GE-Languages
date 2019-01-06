#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena spike-mine-2
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Spike Mine"
                        #:sprite (make-icon "SM" 'gray)
                        #:dart (spike-mine-builder
                                #:speed 10 
                                #:range 50)))))

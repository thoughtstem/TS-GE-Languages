#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena rocket-tower-3
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Rocket Tower"
                        #:sprite (make-icon "RT")
                        #:dart (rocket-tower-builder
                                #:sprite     STUDENT-IMAGE-HERE
                                #:range      200
                                #:damage     1000
                                #:speed      2
                                #:fire-mode  'homing)))))

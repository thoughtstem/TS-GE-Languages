#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena repeater-tower-3
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Repeater Tower"
                        #:sprite (make-icon "RT")
                        #:dart (repeater-tower-builder
                                #:sprite     STUDENT-IMAGE-HERE
                                #:speed      15
                                #:damage     1000
                                #:range      500
                                #:fire-rate  0.1)))))

#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena repeater-tower-2
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Repeater Tower"
                        #:sprite (make-icon "RT")
                        #:dart (repeater-tower-builder
                                #:speed      2
                                #:fire-rate  10)))))

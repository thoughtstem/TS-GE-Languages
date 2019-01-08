#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena single-shot-1
  (battle-arena-game
   #:weapon-list    (list (custom-weapon #:name      "Single Shot"
                                         #:sprite    (make-icon "SS")
                                         #:fire-mode 'normal))))
#lang battle-arena

(define-kata-code battle-arena single-shot-2

  (define (single-dart)
    (custom-dart #:damage 10
                 #:speed  10
                 #:range  50))
  
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name      "Single Shot"
                                      #:sprite    (make-icon "SS")
                                      #:fire-mode 'normal
                                      #:dart      (single-dart)))))
#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena homing-repeater-2

  (define (homing-dart)
    (custom-dart #:damage 15
                 #:speed  8
                 #:range  40))
  
  (battle-arena-game
   #:weapon-list    (list (custom-weapon #:name      "Homing Repeater"
                                         #:sprite    (make-icon "HR")
                                         #:fire-mode 'homing
                                         #:dart      (homing-dart)))))

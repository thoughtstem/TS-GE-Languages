#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena spread-shot-2

  (define (spread-dart)
    (custom-dart #:damage     20
                 #:durability 20
                 #:speed      15))
  
  (battle-arena-game
   #:weapon-list    (list (custom-weapon #:name      "Spread Shot"
                                         #:sprite    (make-icon "SPR")
                                         #:fire-mode 'spread
                                         #:dart      (spread-dart)))))
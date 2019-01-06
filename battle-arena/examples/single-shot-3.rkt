#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena single-shot-3

  (define (single-dart)
    (custom-dart #:sprite (rectangle 10 2 'solid 'cyan)
                 #:damage 10
                 #:speed  10
                 #:range  50))

  (define (single-shot)
    (custom-weapon #:name        "Single Shot"
                   #:sprite      (make-icon "SS")
                   #:fire-mode   'normal
                   #:dart        (single-dart)
                   #:rapid-fire? #f
                   #:rarity      'common))
  
  (battle-arena-game
   #:weapon-list (list (single-shot))))

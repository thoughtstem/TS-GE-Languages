#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena homing-repeater-3

  (define (homing-dart)
    (custom-dart #:sprite (rectangle 10 2 'solid 'pink)
                 #:damage 15
                 #:speed  8
                 #:range  40))

  (define (hoaming-shot)
    (custom-weapon #:name      "Homing Repeater"
                   #:sprite    (make-icon "HR")
                   #:fire-mode 'homing
                   #:dart      (homing-dart)
                   #:rarity    'epic))
  
  (battle-arena-game
   #:weapon-list    (list (hoaming-shot))))

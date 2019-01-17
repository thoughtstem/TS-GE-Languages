#lang battle-arena-starwars
(define (homing-dart)
 (custom-dart #:damage 15
              #:speed  8
              #:range  40))

(starwars-game
#:weapon-list    (list (custom-weapon #:name      "Homing Repeater"
                                      #:sprite    (make-icon "HR")
                                      #:fire-mode 'homing
                                      #:dart      (homing-dart))))


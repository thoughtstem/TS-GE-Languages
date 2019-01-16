#lang starwars-battle-arena
(define (spread-dart)
 (custom-dart #:damage     20
              #:durability 20
              #:speed      15))

(starwars-game
#:weapon-list    (list (custom-weapon #:name      "Spread Shot"
                                      #:sprite    (make-icon "SPR")
                                      #:fire-mode 'spread
                                      #:dart      (spread-dart))))

#lang battle-arena-starwars
(define (spread-dart)
 (custom-dart #:sprite     (rectangle 10 2 'solid 'orange)
              #:damage     20
              #:durability 20
              #:speed      15))

(define (spread-shot)
 (custom-weapon #:name      "Spread Shot"
                #:sprite    (make-icon "SPR")
                #:fire-mode 'spread
                #:dart      (spread-dart)
                #:rarity    'rare))

(starwars-game
#:weapon-list    (list (spread-shot)))


#lang battle-arena
(define (heavy-dart)
 (custom-dart #:sprite (scale 2 flame-sprite)
              #:damage 200
              #:durability 50
              #:speed  10
              #:range  36
              #:components
              (move-in-ring)))

(define (light-dart)
 (custom-dart #:sprite flame-sprite
              #:damage 20
              #:durability 50
              #:speed  10
              #:range  20
              #:components
              (move-in-ring)))

(battle-arena-game
#:weapon-list (list (custom-weapon #:name "Heavy Magic"
                                   #:dart (heavy-dart)
                                   #:rarity 'uncommon)
                    (custom-weapon #:name "Light Magic"
                                   #:dart (light-dart)
                                   #:rarity 'common)))


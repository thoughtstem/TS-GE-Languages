#lang starwars-battle-arena
(define (heavy-dart)
 (custom-dart #:sprite (scale 2 swinging-sword-sprite)
              #:damage 500
              #:durability 200
              #:speed  2
              #:range  10
              #:components (every-tick (change-direction-by 15))))

(define (light-dart)
 (custom-dart #:sprite (scale 2 swinging-sword-sprite)
              #:damage 500
              #:durability 200
              #:speed  2
              #:range  10
              #:components (every-tick (change-direction-by 15))))

(starwars-game
#:weapon-list (list (custom-weapon #:name "Heavy Melee"
                                   #:dart (heavy-dart)
                                   #:rarity 'uncommon)
                    (custom-weapon #:name "Light Melee"
                                   #:dart (light-dart)
                                   #:rarity 'common)))


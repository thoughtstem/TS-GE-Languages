#lang racket
(require ts-kata-util battle-arena)



(define-kata-code battle-arena melee-balance-3
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
  
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name "Heavy Melee"
                                      #:dart (heavy-dart)
                                      #:rarity 'uncommon)
                       (custom-weapon #:name "Light Melee"
                                      #:dart (light-dart)
                                      #:rarity 'common))))


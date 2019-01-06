#lang racket
(require ts-kata-util battle-arena)



(define-kata-code battle-arena melee-balance-1
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name "Light Melee"
                                      #:dart (custom-dart #:sprite swinging-sword-sprite
                                                          #:damage 50
                                                          #:durability 100
                                                          #:speed  1
                                                          #:range  10
                                                          #:components (every-tick (change-direction-by 15)))
                                      #:rarity 'common))))


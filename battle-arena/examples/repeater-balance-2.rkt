#lang racket
(require ts-kata-util battle-arena)



(define-kata-code battle-arena repeater-balance-2
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name "Heavy Repeater"
                                      #:dart (custom-dart #:sprite (scale 2 paint-sprite)
                                                          #:damage 500
                                                          #:durability 100
                                                          #:speed  10
                                                          #:range  50)
                                      #:rarity 'uncommon))))


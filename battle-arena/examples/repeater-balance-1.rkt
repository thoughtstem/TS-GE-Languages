#lang battle-arena

(define-kata-code battle-arena repeater-balance-1
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name "Light Repeater"
                                      #:dart (custom-dart #:sprite paint-sprite
                                                          #:damage 20
                                                          #:durability 1
                                                          #:speed  30
                                                          #:range  50)
                                      #:rarity 'common))))


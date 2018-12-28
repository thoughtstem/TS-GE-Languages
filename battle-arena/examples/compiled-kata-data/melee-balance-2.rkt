#lang battle-arena
(battle-arena-game
#:weapon-list (list (custom-weapon #:name "Heavy Melee"
                                   #:dart (custom-dart #:sprite (scale 2 swinging-sword-sprite)
                                                       #:damage 500
                                                       #:durability 200
                                                       #:speed  2
                                                       #:range  10
                                                       #:components (every-tick (change-direction-by 15)))
                                   #:rarity 'uncommon)))

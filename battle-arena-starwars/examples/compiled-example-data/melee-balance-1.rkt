#lang battle-arena-starwars
(starwars-game
#:weapon-list (list (custom-weapon #:name "Light Melee"
                                   #:dart (custom-dart #:sprite swinging-sword-sprite
                                                       #:damage 50
                                                       #:durability 100
                                                       #:speed  1
                                                       #:range  10
                                                       #:components (every-tick (change-direction-by 15)))
                                   #:rarity 'common)))


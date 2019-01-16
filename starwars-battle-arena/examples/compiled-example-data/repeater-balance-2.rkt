#lang starwars-battle-arena
(starwars-game
#:weapon-list (list (custom-weapon #:name "Heavy Repeater"
                                   #:dart (custom-dart #:sprite (scale 2 paint-sprite)
                                                       #:damage 500
                                                       #:durability 100
                                                       #:speed  10
                                                       #:range  50)
                                   #:rarity 'uncommon)))


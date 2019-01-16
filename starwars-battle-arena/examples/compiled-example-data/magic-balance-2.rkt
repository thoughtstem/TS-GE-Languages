#lang starwars-battle-arena
(starwars-game
#:weapon-list (list (custom-weapon #:name "Heavy Magic"
                                   #:dart (custom-dart #:sprite (scale 2 flame-sprite)
                                                       #:damage 200
                                                       #:durability 50
                                                       #:speed  10
                                                       #:range  36
                                                       #:components
                                                       (move-in-ring))
                                   #:rarity 'uncommon)))


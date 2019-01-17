#lang battle-arena-starwars
(starwars-game
#:weapon-list (list (custom-weapon #:name "Light Repeater"
                                   #:dart (custom-dart #:sprite paint-sprite
                                                       #:damage 20
                                                       #:durability 1
                                                       #:speed  30
                                                       #:range  50)
                                   #:rarity 'common)))


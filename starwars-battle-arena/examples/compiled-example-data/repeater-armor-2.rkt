#lang starwars-battle-arena
(starwars-game
#:item-list (list (custom-armor #:name          "Repeater Armor"
                                #:sprite        (make-icon "RA")
                                #:protects-from "Repeater"
                                #:change-damage (divide-by 2)
                                #:rarity        'rare)))

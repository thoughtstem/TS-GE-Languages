#lang battle-arena
(battle-arena-game
#:item-list (list (custom-armor #:name          "Repeater Armor"
                                #:sprite        (make-icon "RA")
                                #:protects-from "Repeater"
                                #:change-damage (divide-by 2)
                                #:rarity        'rare)))
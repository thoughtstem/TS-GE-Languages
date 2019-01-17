#lang battle-arena-starwars
(starwars-game
#:enemy-list (list (custom-enemy #:amount-in-world 10
                                 #:weapon          (custom-weapon
                                                    #:name "Repeater")))
#:item-list (list (custom-armor #:name          "Repeater Armor"
                                #:sprite        (make-icon "RA")
                                #:protects-from "Repeater"
                                #:change-damage (divide-by 2)
                                #:rarity        'rare)))


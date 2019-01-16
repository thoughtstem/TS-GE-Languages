#lang starwars-battle-arena
(starwars-game
#:enemy-list (list (custom-enemy #:amount-in-world 10
                                 #:weapon          (custom-weapon
                                                    #:name "Sword"
                                                    #:dart (sword))))
#:item-list (list (custom-armor #:name          "Sword Armor"
                                #:sprite        (make-icon "RA")
                                #:protects-from "Sword"
                                #:change-damage (divide-by 2)
                                #:rarity        'rare)))


#lang battle-arena-starwars
(starwars-game
#:item-list (list (custom-armor #:name   "Sword Armor"
                                #:sprite (make-icon "SA")
                                #:protects-from "Sword"
                                #:change-damage (subtract-by 30)
                                #:rarity 'rare)))


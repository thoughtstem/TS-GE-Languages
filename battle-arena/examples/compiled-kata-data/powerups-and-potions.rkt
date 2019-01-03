#lang battle-arena
(battle-arena-game
#:avatar         (custom-avatar #:sprite (random-character-sprite)
                                #:item-slots 3)
#:enemy-list     (list (custom-enemy #:ai 'easy
                                     #:amount-in-world 10))
#:weapon-list    (list (custom-weapon))
#:item-list      (list




























                       (custom-item #:name     "Grow Potion"
                                    #:sprite   (make-icon "BIG" 'red 'white)
                                    #:on-use   (scale-sprite 2 #:for 100)
                                    #:rarity   'common)))

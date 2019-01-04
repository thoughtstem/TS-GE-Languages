#lang battle-arena

(define-kata-code battle-arena powerups-and-potions
  (battle-arena-game
   #:avatar         (custom-avatar #:sprite (random-character-sprite)
                                   #:item-slots 3)
   #:enemy-list     (list (custom-enemy #:ai 'easy
                                        #:amount-in-world 10))
   #:weapon-list    (list (custom-weapon))
   #:item-list      (list (custom-item #:name   "Speed Boost"
                                       #:sprite (make-icon "SB" 'yellow)
                                       #:on-use (multiply-speed-by 2 #:for 200)
                                       #:rarity 'common)
                          (custom-item #:name   "Damage Boost"
                                       #:sprite (make-icon "DB" 'orangered)
                                       #:on-use (change-damage-by 1000 #:for 200)
                                       #:rarity 'epic)
                          #;(custom-item #:name   "Weapon Boost"
                                         #:sprite (make-icon "WB" 'lightblue)
                                         #:on-use (multiply-fire-rate-by 2 #:for 100))
                          (custom-item #:name     "Health Potion"
                                       #:sprite   (make-icon "HP" 'green 'white)
                                       #:on-use   (change-health-by 50)
                                       #:rarity   'uncommon
                                       #:respawn? #t)
                          (custom-item #:name     "Shield Potion"
                                       #:sprite   (make-icon "SP" 'blue 'white)
                                       #:on-use   (change-shield-by 50)
                                       #:rarity   'uncommon
                                       #:respawn? #t)
                          (custom-item #:name     "Max Health Potion"
                                       #:sprite   (make-icon "MHP" 'green 'white)
                                       #:on-use   (set-health-to 100)
                                       #:rarity   'epic)
                          (custom-item #:name     "Max Shield Potion"
                                       #:sprite   (make-icon "MSP" 'blue 'white)
                                       #:on-use   (set-shield-to 100)
                                       #:rarity   'epic)
                          (custom-item #:name     "Grow Potion"
                                       #:sprite   (make-icon "BIG" 'red 'white)
                                       #:on-use   (scale-sprite 2 #:for 100)
                                       #:rarity   'common)
                          (custom-item #:name     "Shrink Potion"
                                       #:sprite   (make-icon "SML" 'blue 'white)
                                       #:on-use   (scale-sprite 0.5 #:for 100)
                                       #:rarity   'common)
                          )))
#lang survival
(survival-game
#:bg     (custom-background #:bg-img FOREST-BG)
#:avatar (custom-avatar #:sprite (random-character-sprite))
#:starvation-rate 20
#:sky        (custom-sky #:length-of-day 500
                         #:night-sky-color 'darkmagenta
                         #:max-darkness 150)
#:coin-list  (list (custom-coin))
#:npc-list   (list (custom-npc))
#:enemy-list (list (custom-enemy #:sprite bat-sprite
                                 #:ai 'medium
                                 #:amount-in-world 10
                                 #:night-only? #t)
                   (custom-enemy #:sprite slime-sprite
                                 #:ai 'easy
                                 #:amount-in-world 10))



#:food-list (list (custom-food #:name "Carrot"
                               #:sprite carrot-sprite
                               #:amount-in-world 30)
                  (custom-food #:name "Carrot Stew"
                               #:sprite carrot-stew-sprite
                               #:heals-by 40
                               #:respawn? #f))
#:crafter-list (list (custom-crafter)))

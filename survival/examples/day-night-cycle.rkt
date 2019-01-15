#lang survival

(require ts-kata-util survival threading)

(define-kata-code survival day-night-cycle  
  (define (my-stew)
    (custom-food #:name "Carrot Stew"
                 #:sprite carrot-stew-sprite
                 #:heals-by 40
                 #:respawn? #f))
  
  (survival-game
   #:bg     (custom-background #:bg-img FOREST-BG)
   #:avatar (custom-avatar #:sprite (random-character-sprite)
                           #:key-mode 'wasd
                           #:mouse-aim? #t)
   #:starvation-rate 20
   
   #:sky (custom-sky #:night-sky-color  'darkmagenta
                     #:length-of-day    4000
                     #:start-of-daytime 1000
                     #:end-of-daytime   3000 
                     #:max-darkness     150)
   
   #:coin-list  (list (custom-coin))
   #:npc-list   (list (custom-npc))
   #:enemy-list (list (custom-enemy #:sprite slime-sprite
                                    #:amount-in-world 10
                                    #:ai 'easy
                                    #:weapon (custom-weapon #:dart (acid #:damage 0))
                                    #:night-only? #t))
   #:food-list  (list (custom-food #:name "Carrot"
                                   #:sprite carrot-sprite
                                   #:amount-in-world 10)
                      (my-stew) )
   #:crafter-list (list (custom-crafter
                         #:menu (crafting-menu-set!
                                 #:recipes (recipe #:product (my-stew)
                                                   #:build-time 20
                                                   #:ingredients (list "Carrot")))))
   ))


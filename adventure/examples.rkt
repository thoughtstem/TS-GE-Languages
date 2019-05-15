#lang racket

(require ts-kata-util adventure)

(define-example-code adventure hello-world-1
  (adventure-game))


; ----------------- AVATAR KATAS

; Make a game with a lightelef avatar with 20 speed
(define-example-code adventure avatar-1

  (adventure-game
   #:avatar (custom-avatar #:sprite lightelf-sprite
                           #:speed  20))
  )


(define-example-code adventure avatar-2
  (define (my-avatar)
    (custom-avatar #:sprite darkknight-sprite
                   #:speed  20
                   #:health 200
                   #:max-health 200))

  (adventure-game
   #:avatar (my-avatar))
  )

(define-example-code adventure avatar-3
  (adventure-game
   #:avatar (custom-avatar #:sprite pirategirl-sprite
                           #:speed  20)
   #:intro-cutscene (custom-cutscene (page pirategirl-sprite
                                           "This is the story of"
                                           "Jordan the Pirate.")))
  )

(define-example-code adventure avatar-4
  (adventure-game
   #:avatar (custom-avatar
             #:sprite madscientist-sprite)
   #:intro-cutscene (custom-cutscene
                     (page "A long time ago,"
                           "In a place far, far, away...")
                     (page (set-sprite-scale 2 madscientist-sprite)
                           "There was a mad scientist"
                           "named Dr. Horrible.")))
  )

; ----------------- COIN KATAS

(define-example-code adventure coin-1
  (adventure-game
   #:coin-list  (list (custom-coin #:sprite gold-coin-sprite
                                   #:value 100
                                   #:amount-in-world 20
                                   #:respawn? #f)))
  )

(define-example-code adventure coin-2
  (define (copper-coin)
    (custom-coin #:sprite copper-coin-sprite
                 #:name   "Copper Coin"
                 #:value  1))

  (define (silver-coin)
    (custom-coin #:sprite silver-coin-sprite
                 #:name   "Silver Coin"
                 #:value  25))
  
  (define (gold-coin)
    (custom-coin #:sprite gold-coin-sprite
                 #:name  "Gold Coin"
                 #:value  50))

  (adventure-game
   #:coin-list  (list (copper-coin)
                      (silver-coin)
                      (gold-coin)))
  )

(define-example-code adventure coin-3

  (define (my-coin)
    (custom-coin #:name "Silver Coin"
                 #:sprite silver-coin-sprite))
  
  (define (my-trick-coin)
    (custom-coin #:name "Gold Coin"
                 #:sprite gold-coin-sprite
                 #:value -1000
                 #:amount-in-world 1
                 #:respawn? #f
                 #:on-pickup (spawn-on-current-tile (custom-enemy #:position (posn 0 0)
                                                                  #:tile 0))))
  
  (adventure-game
   #:coin-list (list (my-coin)
                     (my-trick-coin)))
  )

(define-example-code adventure coin-4

  (define (my-coin)
    (custom-coin #:name "Silver Coin"
                 #:sprite silver-coin-sprite))
  
  (define (my-special-coin)
    (custom-coin #:name "Gold Coin"
                 #:sprite gold-coin-sprite
                 #:value 1000
                 #:amount-in-world 1
                 #:respawn? #f
                 #:on-pickup (spawn (page gold-coin-sprite
                                          "This looks valuable."))))
  
  (adventure-game
   #:coin-list (list (my-coin)
                     (my-special-coin)))
  )

; Make a game with 10 gold coins worth 10 each,
; and an npc with a quest to collect 100 worth and reward you with 50 and a reward item
(define-example-code adventure coin-5
  
  (define (my-coin)
    (custom-coin #:name "Gold Coin"
                 #:sprite gold-coin-sprite
                 #:value 10
                 #:amount-in-world 15
                 #:respawn? #f))

  (define (npc-with-coin-quest)
    (custom-npc #:dialog     (list "I've lost 100 worth of coins"
                                   "in this forest. Can you find"
                                   "them for me?")
                #:quest-list (list (collect-quest #:collect-amount 100
                                                  #:reward-amount 50))))
  
  (adventure-game
   #:npc-list  (list (npc-with-coin-quest))
   #:coin-list (list (my-coin)))
  )

; -----------------

(define-example-code adventure crafter-1
  (adventure-game
   #:avatar       (custom-avatar)
   #:crafter-list (list (custom-crafter)))
  )

(define-example-code adventure crafter-2
  (adventure-game
   #:avatar       (custom-avatar)
   #:food-list    (list (carrot #:amount-in-world 10))
   #:crafter-list (list (custom-crafter
                         #:recipe-list (list carrot-stew-recipe))))
  )
 
(define-example-code adventure crafter-3
  (define (fish-stew)
    (custom-food #:name "Fish Stew"
                 #:sprite fish-stew-sprite
                 #:respawn? #f
                 #:heals-by 50))

  (define fish-stew-recipe
    (recipe #:product (fish-stew)
            #:build-time 40
            #:ingredients (list "Fish")))

  (adventure-game
   #:avatar       (custom-avatar)
   #:food-list    (list (fish #:amount-in-world 10))
   #:crafter-list (list (custom-crafter #:sprite cauldron-sprite
                                        #:recipe-list (list fish-stew-recipe))))
  )

(define-example-code adventure crafter-4  
  (define (fish-stew)
    (custom-food #:name "Fish Stew"
                 #:sprite fish-stew-sprite
                 #:respawn? #f
                 #:heals-by 50))

  (define fish-stew-recipe
    (recipe #:product (fish-stew)
            #:build-time 40
            #:ingredients (list "Fish")))

  (define (my-cauldron)
    (custom-crafter #:sprite      cauldron-sprite
                    #:position    (posn 200 200)
                    #:tile        2
                    #:recipe-list (list carrot-stew-recipe
                                        fish-stew-recipe)))
  
  (adventure-game
   #:avatar       (custom-avatar)
   #:food-list    (list (carrot #:amount-in-world 10)
                        (fish   #:amount-in-world 10))
   #:crafter-list (list (my-cauldron)))
  )

; sword, damage, has-gold? options (spear) fire-magic, etc
(define-example-code adventure weapon-crafter-1
  (define my-sword-recipe
    (recipe #:product (sword)
            #:build-time 20))
  
  (adventure-game
   #:avatar       (custom-avatar)
   #:crafter-list (list (custom-crafter
                         #:sprite      wood-table-sprite
                         #:recipe-list (list my-sword-recipe))))
  )

(define-example-code adventure weapon-crafter-2
  (define my-sword-recipe
    (recipe #:product (sword #:name "Heavy Sword"
                             #:damage 100)
            #:build-time 40))
  
  (adventure-game
   #:avatar       (custom-avatar)
   #:crafter-list (list (custom-crafter
                         #:sprite      wood-table-sprite
                         #:recipe-list (list my-sword-recipe))))
  )

(define-example-code adventure weapon-crafter-3
  (define my-fire-magic-recipe
    (recipe #:product (fire-magic  #:name "Fire Magic"
                                   #:speed 5)
            #:build-time 60
            #:cost       100))
  
  (adventure-game
   #:avatar       (custom-avatar)
   #:coin-list    (list (custom-coin #:value 20
                                     #:amount-in-world 10))
   #:crafter-list (list (custom-crafter
                         #:sprite wood-table-sprite
                         #:recipe-list (list my-fire-magic-recipe))))
  )

; -----------------

(define-example-code adventure sky-1 
  (adventure-game
   #:avatar (custom-avatar)
   #:sky    (custom-sky #:length-of-day 5000))
  )

(define-example-code adventure sky-2 
  (adventure-game
   #:avatar (custom-avatar)
   #:sky    (custom-sky #:length-of-day 500
                        #:max-darkness  255))
  )

(define-example-code adventure sky-3 
  (adventure-game
   #:avatar (custom-avatar)
   #:sky (custom-sky #:night-sky-color  'darkmagenta
                     #:max-darkness     150))
  )

(define-example-code adventure sky-4 

  (adventure-game
   #:avatar       (custom-avatar)
   #:enemy-list   (list (custom-enemy #:amount-in-world 20
                                      #:night-only? #t))
   #:sky          (custom-sky #:length-of-day    2400
                              #:start-of-daytime 200
                              #:end-of-daytime   2200))
  )

; -----------------

(define-example-code adventure enemy-1
  (adventure-game
   #:enemy-list (list (curry custom-enemy
                             #:ai              'medium
                             #:amount-in-world 10
                             #:night-only? #t
                             #:health 200)))
  )

(define-example-code adventure enemy-2
  (define (easy-enemy)
    (custom-enemy #:ai           'easy
                  #:sprite       slime-sprite
                  #:amount-in-world 4))
  
  (define (medium-enemy)
    (custom-enemy #:ai              'medium
                  #:sprite          bat-sprite
                  #:amount-in-world 2))

  (define (hard-enemy)
    (custom-enemy #:ai              'hard
                  #:sprite          snake-sprite
                  #:night-only? #t))
 
  (adventure-game
   #:enemy-list (list (easy-enemy)
                      (medium-enemy)
                      (hard-enemy)))
  )

; Make a game with 10 enemies and an npc with a quest to kill 5
; and reward you with 50 and a reward-item

(define-example-code adventure enemy-3

  (define (my-silver-coin)
    (custom-coin #:sprite silver-coin-sprite
                 #:value 5))
  
  (define (my-gold-coin)
    (custom-coin #:sprite gold-coin-sprite
                 #:value 20))
  
  (define (easy-enemy)
    (custom-enemy #:amount-in-world 5
                  #:loot-list (list (my-silver-coin))))

  (define (hard-enemy)
    (custom-enemy #:amount-in-world 3
                  #:ai 'hard
                  #:loot-list (list (my-gold-coin)
                                    (my-gold-coin))))
  (adventure-game
   #:weapon-list (list (spear))
   #:enemy-list  (list (easy-enemy)
                       (hard-enemy)))
  )

; Make a game with 10 enemies and an npc with a quest to kill 5
; and reward you with 50 and a reward-item

(define-example-code adventure enemy-4
  
  (define (easy-enemy)
    (custom-enemy #:amount-in-world 5))

  (define (hard-enemy)
    (custom-enemy #:amount-in-world 3
                  #:ai 'hard
                  #:weapon (fireball)))
  
  (adventure-game
   #:avatar         (custom-avatar #:sprite steampunkboy-sprite)
   #:death-cutscene (custom-cutscene (page (set-sprite-angle 90 (render steampunkboy-sprite))
                                           "You died!")
                                     (page "Try harder!"))
   #:weapon-list (list (spear))
   #:enemy-list  (list (easy-enemy)
                       (hard-enemy)))
  )

; Make a game with 10 enemies and an npc with a quest to kill 5
; and reward you with 50 and a reward-item

(define-example-code adventure enemy-5

  (define my-hunt-quest
    (hunt-quest #:hunt-amount 5
                #:reward-amount 50
                #:reward-item (sword)))
  
  (adventure-game
   #:death-cutscene (custom-cutscene (page "You died!")
                                     (page "Try harder!"))
   #:npc-list (list (custom-npc #:dialog (list "Monsters are keeping me from"
                                               "my important work. Can you"
                                               "kill 5 of them for me?")
                                #:quest-list (list my-hunt-quest)))
   #:weapon-list (list (fireball))
   #:enemy-list  (list (curry custom-enemy #:amount-in-world 10)))
  )

; -----------------

(define-example-code adventure food-1
  (adventure-game
   #:avatar     (custom-avatar)
   #:food-list  (list (custom-food #:amount-in-world 10)))
  )

(define-example-code adventure food-2
  (define (my-food)
    (custom-food #:amount-in-world 2
                 #:heals-by        20))
 
  (adventure-game
   #:avatar     (custom-avatar)
   #:food-list  (list (my-food)))
  )


(define-example-code adventure food-3
  (define (my-food)
    (custom-food #:sprite          apples-sprite
                 #:name            "Apples"
                 #:amount-in-world 2
                 #:heals-by        20))

  (adventure-game
   #:avatar     (custom-avatar)
   #:food-list  (list (my-food)))
  )

(define-example-code adventure food-4

  (define (my-food)
    (custom-food #:sprite          apples-sprite
                 #:name            "Apples"
                 #:amount-in-world 2
                 #:heals-by        20))

  (define (special-food)
    (custom-food #:sprite          cherry-sprite
                 #:name            "Cherry"
                 #:amount-in-world 1
                 #:heals-by        50
                 #:respawn?        #f))

  (adventure-game
   #:avatar     (custom-avatar)
   #:food-list  (list (my-food)
                      (special-food))))

(define-example-code adventure food-5
  (define (my-food)
    (custom-food #:sprite          cherry-sprite
                 #:name            "Cherry"
                 #:amount-in-world 20
                 #:heals-by        50))
  
  (adventure-game
   #:avatar          (custom-avatar)
   #:food-list       (list (my-food)))
  )
; -----------------

(define-example-code adventure npc-1
  (adventure-game
   #:avatar   (custom-avatar)
   #:npc-list (list (custom-npc)))
  )


(define-example-code adventure npc-2
  (define (my-npc)
    (custom-npc
     #:sprite witch-sprite
     #:name   "Witch"))

  (adventure-game
   #:avatar   (custom-avatar)
   #:npc-list (list (my-npc)))
  )

(define-example-code adventure npc-3
  (define (my-npc)
    (custom-npc
     #:sprite witch-sprite
     #:name   "Witch"
     #:tile   3
     #:mode   'follow))

  (adventure-game
   #:avatar   (custom-avatar)
   #:npc-list (list (my-npc)))
  )

(define-example-code adventure npc-4
  (define (my-npc)
    (custom-npc
     #:dialog (list "Woah, who are you??"
                    "Nevermind -- I'm too busy."
                    "Move along, now!")))
  (adventure-game
   #:avatar   (custom-avatar)
   #:npc-list (list (my-npc)))
  )

(define-example-code adventure npc-5
  (define (my-npc)
    (custom-npc
     #:name   "Francis"
     #:tile   4
     #:dialog (list "Greetings!"
                    "You better find some food soon...")))

  (define (another-npc)
    (custom-npc
     #:sprite witch-sprite
     #:mode   'pace
     #:dialog (list "Now where did I put it..."
                    "Have you seen an eye of newt?"
                    "Oh, I think I see it!")))

  (adventure-game
   #:avatar   (custom-avatar)
   #:npc-list (list (my-npc) (another-npc)))
  )

; -----------------

(define-example-code adventure bg-1
  (adventure-game
   #:avatar (custom-avatar)
   #:bg (custom-bg))
  )

(define-example-code adventure bg-2
  (adventure-game
   #:avatar (custom-avatar)
   #:bg (custom-bg #:image DESERT-BG))
  )

(define-example-code adventure bg-3
  (define (my-bg)
    (custom-bg
     #:image LAVA-BG
     #:rows 2
     #:columns 2))

  (adventure-game
   #:avatar (custom-avatar)
   #:bg (my-bg))
  )

(define-example-code adventure bg-4
  (define (my-bg)
    (custom-bg #:image LAVA-BG
               #:rows 2
               #:columns 2
               #:start-tile 3
               #:hd? #t))
 
  (adventure-game #:bg (my-bg))
  )
  

; -----------------

; ==== LEVEL DESIGN KATAS ====

; Make a game with a forest background
; filled with default world objects
(define-example-code adventure level-design-1

  (adventure-game
   #:bg (custom-bg #:image FOREST-BG)
   #:enable-world-objects? #t)
  
  )

; Make a game with a pink background
; filled with random color and high definition candy-cane-trees and snow-pine-trees
(define-example-code adventure level-design-2

  (adventure-game
   #:bg             (custom-bg #:image PINK-BG)
   #:other-entities (make-world-objects candy-cane-tree
                                        snow-pine-tree
                                        #:hd? #t
                                        #:random-color? #t))
  
  )

; Make a game with an HD desert background
; filled with random HD brown rocks
(define-example-code adventure level-design-3

  (adventure-game
   #:bg             (custom-bg #:image DESERT-BG
                               #:hd? #t)
   #:other-entities (make-world-objects random-brown-rock
                                        random-brown-rock
                                        #:hd? #t))
  
  )

; Make a game with an HD lava background
; filled with random HD gray rocks
(define-example-code adventure level-design-4

  (adventure-game
   #:bg             (custom-bg #:image LAVA-BG
                               #:hd? #t)
   #:intro-cutscene (custom-cutscene (page "Once upon a time"
                                           "on a volcanic moon"
                                           "of a distance world...")
                                     (page "There was a lone soldier"
                                           "who was banished from his"
                                           "homeworld.")
                                     (page (set-sprite-scale 2 basic-sprite)
                                           "This is his story."))
   #:other-entities (make-world-objects random-gray-rock
                                        random-gray-rock
                                        #:hd? #t))
  )

; Make a game with any background and
; 3 world objects with customized position, tile, size, and/or hue
(define-example-code adventure level-design-5
  
  (adventure-game
   #:bg             (custom-bg)
   #:avatar         (custom-avatar)
   #:other-entities (reduce-quality-by 2 (barrels (posn 100 200) #:tile 0))
                    (large-gray-rock  (posn 100 200) #:tile 1 #:size 2)
                    (brick-house      (posn 200 200) #:tile 2 #:hue (random 360)))
  )

; ==============================

; -------------------------- FETCH QUEST KATAS

 ;Make a game with a basic fetch quest
(define-example-code adventure fetch-quest-1
  (define lost-cat
    (custom-item #:name "Mylo"
                 #:sprite cat-sprite))
  
  (adventure-game
   #:npc-list (list (custom-npc #:dialog (list "Can you help me find my cat?"
                                               "I've looked everywhere!")
                                #:quest-list (list (fetch-quest #:item lost-cat)))))
  )

 ;Make a game with a basic fetch quest with a cutscene
(define-example-code adventure fetch-quest-2
  (define lost-cat
    (custom-item #:name "Mylo"
                 #:sprite cat-sprite))

  (define my-cutscene
    (custom-cutscene (page (set-sprite-scale 2 cat-sprite)
                           "Mylo is happy to be home!")))
  
  (adventure-game
   #:npc-list (list (custom-npc #:dialog (list "Can you help me find my cat?")
                                #:quest-list (list (fetch-quest #:item lost-cat
                                                                #:cutscene my-cutscene)))))
  )

(define-example-code adventure fetch-quest-3
  
  (define fetch-quest-1
    (fetch-quest #:item (custom-item #:name "Mylo"
                                     #:sprite cat-sprite)
                 #:reward-amount 200))
  
  (define fetch-quest-2
    (fetch-quest #:item (custom-item #:name "Buttons"
                                     #:sprite white-cat-sprite)
                 #:reward-amount 200))

  (adventure-game
   #:npc-list (list (custom-npc #:name "Erin"
                                #:sprite lightelf-sprite
                                #:dialog (list "Can you help me find my cats?"
                                               "I'll give you a reward for each cat.")
                                #:quest-list (list fetch-quest-1
                                                   fetch-quest-2))))
  )

;Make a game that has an npc with a fetch quest (with customized dialog and reward)
(define-example-code adventure fetch-quest-4
  
  (define my-fetch-quest
    (fetch-quest #:item (custom-item #:name "Mylo"
                                     #:sprite cat-sprite)
                 #:quest-complete-dialog (list "Thank you for finding Mylo!")
                 #:new-response-dialog   (list "Thanks again for your help.")
                 #:reward-amount 400 ))

  (adventure-game
   #:npc-list (list (custom-npc #:name "Erin"
                                #:sprite lightelf-sprite
                                #:dialog (list "Can you help me find my cat?")
                                #:quest-list (list my-fetch-quest))))
  )

; Make a game that has a customized quest item with on-store and on-drop cutscenes
; and an npc with a fetch quest (with reward and cutscene)
(define-example-code adventure fetch-quest-5
  
  (define my-quest-item
    (custom-item #:name "Mylo"
                 #:sprite  cat-sprite
                 #:on-store (spawn (page (set-sprite-scale 2 cat-sprite)
                                         "This must be Erin's lost cat"))
                 #:on-drop  (spawn (page "Maybe I shouldn't leave him"
                                         "alone like this.")
                                   #:rule (not/r (entity-in-game? "Erin")))))

  (adventure-game
   #:npc-list (list (custom-npc #:name "Erin"
                                #:sprite     lightelf-sprite
                                #:dialog     (list "Can you help me find my cat?")
                                #:quest-list (fetch-quest #:item my-quest-item
                                                          #:reward-amount 500
                                                          #:cutscene (page (list (set-sprite-x-offset -50 lightelf-sprite)
                                                                                 (set-sprite-x-offset 50 cat-sprite))
                                                                           "Mylo, I've missed you!"))
                                )))
  )




;Tests all examples as games for 10 ticks
(test-all-examples-as-games 'adventure)


#lang racket

(require ts-kata-util ;adventure
         )

(define-example-code
  ;#:with-test (test game-test)
  adventure hello-world-1
  (adventure-game))


; ----------------- AVATAR KATAS

; Make a game with a lightelf avatar with 20 speed
(define-example-code
  ;#:with-test (test game-test)
  adventure avatar-1

  (adventure-game
    #:avatar (basic-avatar #:sprite lightelf-sprite
                           #:speed  20))
  )


(define-example-code
  ;#:with-test (test game-test)
  adventure avatar-2
  (define (my-avatar)
    (basic-avatar #:sprite darkknight-sprite
                  #:speed  20
                  #:health 200
                  #:max-health 200))

  (adventure-game
    #:avatar (my-avatar))
  )

(define-example-code
  ;#:with-test (test game-test)
  adventure avatar-3
  (adventure-game
    #:avatar (basic-avatar #:sprite pirategirl-sprite
                           #:speed  20)
    #:intro-cutscene (basic-cutscene (page pirategirl-sprite
                                           "This is the story of"
                                           "Jordan the Pirate.")))
  )

(define-example-code
  ;#:with-test (test game-test)
  adventure avatar-4
  (adventure-game
    #:avatar (basic-avatar
               #:sprite madscientist-sprite)
    #:intro-cutscene (basic-cutscene
                       (page "A long time ago,"
                             "In a place far, far, away...")
                       (page (set-sprite-scale 2 madscientist-sprite)
                             "There was a mad scientist"
                             "named Dr. Horrible.")))
  )

; ----------------- COIN KATAS

(define-example-code
  ;#:with-test (test game-test)
  adventure coin-1
  (adventure-game
    #:coin-list  (list (basic-coin #:sprite goldcoin-sprite
                                   #:value 100
                                   #:amount-in-world 20
                                   #:respawn? #f)))
  )

(define-example-code
  ;#:with-test (test game-test)
  adventure coin-2
  (define (copper-coin)
    (basic-coin #:sprite coppercoin-sprite
                #:name   "Copper Coin"
                #:value  1))

  (define (silver-coin)
    (basic-coin #:sprite silvercoin-sprite
                #:name   "Silver Coin"
                #:value  25))

  (define (gold-coin)
    (basic-coin #:sprite goldcoin-sprite
                #:name  "Gold Coin"
                #:value  50))

  (adventure-game
    #:coin-list  (list (copper-coin)
                       (silver-coin)
                       (gold-coin)))
  )

(define-example-code
  ;#:with-test (test game-test)
  adventure coin-3
  (define (my-trick-coin)
    (basic-coin #:name "Gold Coin"
                #:sprite goldcoin-sprite
                #:value -1000
                #:amount-in-world 1
                #:respawn? #f
                #:on-pickup (spawn-on-current-tile (basic-enemy #:position (posn 0 0)
                                                                #:tile 0))))

  (adventure-game
    #:coin-list (list (my-trick-coin)))
  )

(define-example-code
  ;#:with-test (test game-test)
  adventure coin-4
  (define (my-special-coin)
    (basic-coin #:name "Gold Coin"
                #:sprite goldcoin-sprite
                #:value 1000
                #:amount-in-world 1
                #:respawn? #f
                #:on-pickup (spawn (page goldcoin-sprite
                                         "This looks valuable."))))

  (adventure-game
    #:coin-list (list (my-special-coin)))
  )

; Make a game with 10 gold coins worth 10 each,
; and an npc with a quest to collect 100 worth and reward you with 50 and a reward item
(define-example-code
  ;#:with-test (test game-test)
  adventure coin-5

  (define (my-coin)
    (basic-coin  #:amount-in-world 15
                 #:respawn? #f))

  (define (npc-with-coin-quest)
    (basic-npc #:dialog     (list "I've lost my coins..."
                                  "...100 points worth!"
                                  "Can you find them for me?")
               #:quest-list (list (collect-quest #:collect-amount 100
                                                 #:reward-amount 50))))

  (adventure-game
    #:npc-list  (list (npc-with-coin-quest))
    #:coin-list (list (my-coin)))
  )

; ==== LEVEL DESIGN KATAS ====

; Make a game with a forest background
; filled with default world objects
(define-example-code
  ;#:with-test (test game-test)
  adventure level-design-1

  (adventure-game
    #:bg (basic-bg #:image FOREST-BG)
    #:enable-world-objects? #t)

  )

; Make a game with a pink background
; filled with random color and high definition candy-cane-trees and snow-pine-trees
(define-example-code
  ;#:with-test (test game-test)
  adventure level-design-2

  (adventure-game
    #:bg             (basic-bg #:image PINK-BG)
    #:other-entities (make-world-objects candy-cane-tree
                                         snow-pine-tree
                                         #:hd? #t
                                         #:random-color? #t))

  )

; Make a game with an HD desert background
; filled with random HD brown rocks
(define-example-code
  ;#:with-test (test game-test)
  adventure level-design-3

  (adventure-game
    #:bg             (basic-bg #:image DESERT-BG
                               #:hd? #t)
    #:other-entities (make-world-objects random-brown-rock
                                         random-brown-rock
                                         #:hd? #t))

  )

; Make a game with an HD lava background
; filled with random HD gray rocks
(define-example-code
  ;#:with-test (test game-test)
  adventure level-design-4

  (adventure-game
    #:bg             (basic-bg #:image LAVA-BG
                               #:hd? #t)
    #:intro-cutscene (basic-cutscene (page "Once upon a time"
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
; 3 world objects with basicized position, tile, size, and/or hue
(define-example-code
  ;#:with-test (test game-test)
  adventure level-design-5

  (adventure-game
    #:bg             (basic-bg)
    #:avatar         (basic-avatar)
    #:other-entities (reduce-quality-by 2 (barrels (posn 100 200) #:tile 0))
    (large-gray-rock  (posn 100 200) #:tile 1 #:size 2)
    (brick-house      (posn 200 200) #:tile 2 #:hue (random 360)))
  )

; -------------------------- FETCH QUEST KATAS

;Make a game with a basic fetch quest
(define-example-code
  ;#:with-test (test game-test)
  adventure fetch-quest-1
  (define lost-cat
    (basic-item #:name "Mylo"
                #:sprite cat-sprite))

  (adventure-game
    #:npc-list (list (basic-npc #:dialog (list "Can you help me find my cat?"
                                               "I've looked everywhere!")
                                #:quest-list (list (fetch-quest #:item lost-cat)))))
  )

;Make a game with a basic fetch quest with a cutscene
(define-example-code
  ;#:with-test (test game-test)
  adventure fetch-quest-2
  (define lost-cat
    (basic-item #:name "Mylo"
                #:sprite cat-sprite))

  (define my-cutscene
    (basic-cutscene (page (set-sprite-scale 2 cat-sprite)
                          "Mylo is happy to be home!")))

  (adventure-game
    #:npc-list (list (basic-npc #:dialog (list "Can you help me find my cat?")
                                #:quest-list (list (fetch-quest #:item lost-cat
                                                                #:cutscene my-cutscene)))))
  )

(define-example-code
  ;#:with-test (test game-test)
  adventure fetch-quest-3

  (define fetch-quest-1
    (fetch-quest #:item (basic-item #:name "Mylo"
                                    #:sprite cat-sprite)
                 #:reward-amount 200))

  (define fetch-quest-2
    (fetch-quest #:item (basic-item #:name "Buttons"
                                    #:sprite whitecat-sprite)
                 #:reward-amount 200))

  (adventure-game
    #:npc-list (list (basic-npc #:name "Erin"
                                #:sprite lightelf-sprite
                                #:dialog (list "Can you help me find my cats?"
                                               "I'll give you a reward for each cat.")
                                #:quest-list (list fetch-quest-1
                                                   fetch-quest-2))))
  )

;Make a game that has an npc with a fetch quest (with basicized dialog and reward)
(define-example-code
  ;#:with-test (test game-test)
  adventure fetch-quest-4

  (define my-fetch-quest
    (fetch-quest #:item (basic-item #:name "Mylo"
                                    #:sprite cat-sprite)
                 #:quest-complete-dialog (list "Thank you for finding Mylo!")
                 #:new-response-dialog   (list "Thanks again for your help.")
                 #:reward-amount 400 ))

  (adventure-game
    #:npc-list (list (basic-npc #:name "Erin"
                                #:sprite lightelf-sprite
                                #:dialog (list "Can you help me find my cat?")
                                #:quest-list (list my-fetch-quest))))
  )

; Make a game that has a basicized quest item with on-store and on-drop cutscenes
; and an npc with a fetch quest (with reward and cutscene)
(define-example-code
  ;#:with-test (test game-test)
  adventure fetch-quest-5

  (define my-quest-item
    (basic-item #:name "Mylo"
                #:sprite  cat-sprite
                #:on-store (spawn (page (set-sprite-scale 2 cat-sprite)
                                        "This must be Erin's lost cat"))
                #:on-drop  (spawn (page "Maybe I shouldn't leave him"
                                        "alone like this.")
                                  #:rule (not/r (entity-in-game? "Erin")))))

  (adventure-game
    #:npc-list (list (basic-npc #:name "Erin"
                                #:sprite     lightelf-sprite
                                #:dialog     (list "Can you help my find my cat?")
                                #:quest-list (fetch-quest #:item my-quest-item
                                                          #:reward-amount 500
                                                          #:cutscene (page (list (set-sprite-x-offset -50 lightelf-sprite)
                                                                                 (set-sprite-x-offset 50 cat-sprite))
                                                                           "Mylo, I've missed you!"))
                                )))
  )

; -------------------------- LOOT QUEST KATAS

;Make a game with a basic loot quest
(define-example-code
  ;#:with-test (test game-test)
  adventure loot-quest-1
  (define stolen-chest (basic-item))

  (adventure-game
    #:enemy-list  (list (basic-enemy #:loot-list (list stolen-chest)))
    #:npc-list    (list (basic-npc #:dialog (list "Someone stole my chest!")
                                   #:quest-list (list (loot-quest #:item stolen-chest))))
    #:weapon-list (list (spear)))
  )

;Make a game with an npc that stole a cat and a quest to get him back.
(define-example-code
  ;#:with-test (test game-test)
  adventure loot-quest-2
  (define stolen-cat
    (make-storable
      (basic-npc #:sprite cat-sprite
                 #:dialog (list "Help me!"))))

  (adventure-game
    #:enemy-list  (list (basic-enemy #:loot-list (list stolen-cat)))
    #:npc-list    (list (basic-npc #:dialog (list "Someone took my cat!")
                                   #:quest-list (list (loot-quest #:item stolen-cat))))
    #:weapon-list (list (fireball #:damage 50)))
  )

;Make a game with a loot quest and a quest cutscene
(define-example-code
  ;#:with-test (test game-test)
  adventure loot-quest-3
  (define stolen-food
    (basic-food #:name "Apples"
                #:sprite apples-sprite))

  (define my-cutscene
    (basic-cutscene (page (set-sprite-scale 2 apples-sprite)
                          "Now I can make Grandma's apple pie!")))

  (adventure-game
    #:enemy-list  (list (basic-enemy #:loot-list (list stolen-food)))
    #:npc-list    (list (basic-npc #:dialog (list "Help! Someone stole my apples!")
                                   #:quest-list (list (loot-quest #:item stolen-food
                                                                  #:cutscene my-cutscene))))
    #:weapon-list (list (repeater #:damage 50)))
  )

;Make a game that has an npc with a loot quest (with basicized dialog and reward)
(define-example-code
  ;#:with-test (test game-test)
  adventure loot-quest-4

  (define stolen-cat
    (make-storable (basic-npc #:sprite cat-sprite
                              #:dialog (list "Meow!"))))

  (define my-loot-quest
    (loot-quest #:item stolen-cat
                #:quest-complete-dialog (list "Thank you for finding my cat!")
                #:new-response-dialog   (list "Thanks again for your help.")
                #:reward-amount 400 ))

  (adventure-game
    #:enemy-list (list (basic-enemy #:loot-list (list stolen-cat)))
    #:npc-list   (list (basic-npc #:dialog (list "Help! Someone stole my cat!")
                                  #:quest-list (list my-loot-quest)))
    #:weapon-list (list (ice-magic)))
  )

; Make a game that has a basicized quest item with on-store and on-drop cutscenes
; and an npc with a loot quest
(define-example-code
  ;#:with-test (test game-test)
  adventure loot-quest-5

  (define stolen-item
    (basic-item #:name "Empty Bowl"
                #:sprite  bowl-sprite
                #:on-store (spawn (page (set-sprite-scale 2 bowl-sprite)
                                        "This must be JOrdan's stolen bowl."))
                #:on-drop  (spawn (page "Maybe I shouldn't leave it here.")
                                  #:rule (not/r (entity-in-game? "Jordan")))))

  (adventure-game
    #:enemy-list  (list (basic-enemy #:loot-list (list stolen-item)))
    #:npc-list    (list (basic-npc #:name "Jordan"
                                   #:dialog     (list "That thief took my only bowl!"
                                                      "Please get it back!")
                                   #:quest-list (loot-quest #:item stolen-item)
                                   ))
    #:weapon-list (list (fireball #:damage 50)))
  )

; -----------------

(define-example-code
  ;#:with-test (test game-test)
  adventure enemy-1
  (adventure-game
    #:enemy-list (list (curry basic-enemy
                              #:ai              'medium
                              #:amount-in-world 10
                              #:night-only? #t
                              #:health 200)))
  )

(define-example-code
  ;#:with-test (test game-test)
  adventure enemy-2
  (define (easy-enemy)
    (basic-enemy #:ai           'easy
                 #:sprite       slime-sprite
                 #:amount-in-world 4))

  (define (medium-enemy)
    (basic-enemy #:ai              'medium
                 #:sprite          bat-sprite
                 #:amount-in-world 2))

  (define (hard-enemy)
    (basic-enemy #:ai              'hard
                 #:sprite          snake-sprite
                 #:night-only? #t))

  (adventure-game
    #:enemy-list (list (easy-enemy)
                       (medium-enemy)
                       (hard-enemy)))
  )

; Make a game with 10 enemies and an npc with a quest to kill 5
; and reward you with 50 and a reward-item

(define-example-code
  ;#:with-test (test game-test)
  adventure enemy-3  
  (define (my-gold-coin)
    (basic-coin #:sprite goldcoin-sprite
                #:value 20))

  (define (hard-enemy)
    (basic-enemy #:amount-in-world 3
                 #:ai 'hard
                 #:loot-list (list (my-gold-coin)
                                   (my-gold-coin))))

  (adventure-game
    #:weapon-list (list (spear))
    #:enemy-list  (list (hard-enemy)))
  )

; Make a game with 10 enemies and an npc with a quest to kill 5
; and reward you with 50 and a reward-item

(define-example-code
  ;#:with-test (test game-test)
  adventure enemy-4

  (define (easy-enemy)
    (basic-enemy #:amount-in-world 5))

  (define (hard-enemy)
    (basic-enemy #:amount-in-world 3
                 #:ai 'hard
                 #:weapon (fireball)))

  (adventure-game
    #:avatar         (basic-avatar #:sprite steampunkboy-sprite)
    #:death-cutscene (basic-cutscene (page (set-sprite-angle 90 (render steampunkboy-sprite))
                                           "You died!")
                                     (page "Try harder!"))
    #:weapon-list (list (spear))
    #:enemy-list  (list (easy-enemy)
                        (hard-enemy)))
  )

; Make a game with 10 enemies and an npc with a quest to kill 5
; and reward you with 50 and a reward-item

(define-example-code
  ;#:with-test (test game-test)
  adventure enemy-5

  (define my-hunt-quest
    (hunt-quest #:hunt-amount 5
                #:reward-amount 50
                #:reward-item (sword)))

  (adventure-game
    #:death-cutscene (basic-cutscene (page "You died!"
                                           "Try harder!"))
    #:npc-list (list (basic-npc #:dialog (list "These monsters are annoying."
                                               "Can you get rid of 5?")
                                #:quest-list (list my-hunt-quest)))
    #:weapon-list (list (fireball))
    #:enemy-list  (list (curry basic-enemy #:amount-in-world 10)))
  )

;===== NPC KATAS =====
;TODO get rid of npc from survival
;in-line 1 npc with default dialog all other keywords
;QUESTION additional keywords to add? scale, speed?
(define-example-code
  ;#:with-test (test game-test)
  adventure npc-1

  (adventure-game
   #:npc-list (list (basic-npc
                     #:sprite   witch-sprite
                     #:name     "Witch"
                     #:mode     'follow
                     #:position (posn 200 200)
                     #:tile     3)))
  )

;define 2 npc with simple dialog (inline with def)
(define-example-code
  ;#:with-test (test game-test)
  adventure npc-2

  (define (polite-npc)
    (basic-npc
      #:name "Riley"
      #:dialog (list "Oh hello there! I'm Riley."
                     "Beautiful day today!")))

  (define (rude-npc)
    (basic-npc
      #:name "..."
      #:dialog (list "Woah, who are you??"
                     "Nevermind -- I'm too busy."
                     "Move along, now!")))

  (adventure-game
    #:npc-list (list (polite-npc) (rude-npc)))
  )

;1 npc with multiple lines of dialog (dialog defined, npc in-line)
(define-example-code
  ;#:with-test (test game-test)
  adventure npc-3
  (define player-dialog
    (player-dialog-with "Jordan"
                        #:dialog-list (list "Hello. What's your name?"
                                            "Are you lost?"
                                            "What's the meaning of life?")))
  (define npc-response
    (list (list "I'm Jordan,"
                "but you can call me J.")
          (list "Nope. Just exploring!")
          (list "That's a strange question...")))

  (adventure-game
    #:avatar (basic-avatar #:components player-dialog)
    #:npc-list (list (basic-npc #:name "Jordan"
                                #:dialog npc-response)))
  )

;2 npc with different dialog
(define-example-code
  ;#:with-test (test game-test)
  adventure npc-4

  (adventure-game
    #:avatar (basic-avatar #:components (random-player-dialog-with "Dakota")
                           (random-player-dialog-with "Alex"))
    #:npc-list (list (basic-npc #:name "Dakota"
                                #:dialog (random-npc-response))
                     (basic-npc #:name "Alex"
                                #:dialog (random-npc-response))))
  )

;fetch quest with quest finish dialog
(define-example-code
  ;#:with-test (test game-test)
  adventure npc-5

  (define spear-quest
    (fetch-quest #:item (spear)
                 #:quest-complete-dialog (list "YAY! MY SPEAR!")
                 #:new-response-dialog (list "Thanks again!")))

  (adventure-game
    #:npc-list (list (basic-npc  #:name "Charlie"
                                 #:dialog (list "Can you find my spear?")
                                 #:quest-list (list spear-quest))))
  )
; -----------

(define-example-code
  ;#:with-test (test game-test)
  adventure crafter-1
  (adventure-game
    #:avatar       (basic-avatar)
    #:crafter-list (list (basic-crafter)))
  )

(define-example-code
  ;#:with-test (test game-test)
  adventure crafter-2
  (adventure-game
    #:avatar       (basic-avatar)
    #:food-list    (list (carrot #:amount-in-world 10))
    #:crafter-list (list (basic-crafter
                           #:recipe-list (list carrot-stew-recipe))))
  )

(define-example-code
  ;#:with-test (test game-test)
  adventure crafter-3
  (define (fish-stew)
    (basic-food #:name "Fish Stew"
                #:sprite fishstew-sprite
                #:respawn? #f
                #:heals-by 50))

  (define fish-stew-recipe
    (recipe #:product (fish-stew)
            #:build-time 40
            #:ingredients (list "Fish")))

  (adventure-game
    #:avatar       (basic-avatar)
    #:food-list    (list (fish #:amount-in-world 10))
    #:crafter-list (list (basic-crafter #:sprite cauldron-sprite
                                        #:recipe-list (list fish-stew-recipe))))
  )

(define-example-code
  ;#:with-test (test game-test)
  adventure crafter-4  
  (define (fish-stew)
    (basic-food #:name "Fish Stew"
                #:sprite fishstew-sprite
                #:respawn? #f
                #:heals-by 50))

  (define fish-stew-recipe
    (recipe #:product (fish-stew)
            #:build-time 40
            #:ingredients (list "Fish")))

  (define (my-cauldron)
    (basic-crafter #:sprite      cauldron-sprite
                   #:position    (posn 200 200)
                   #:tile        2
                   #:recipe-list (list carrot-stew-recipe
                                       fish-stew-recipe)))

  (adventure-game
    #:avatar       (basic-avatar)
    #:food-list    (list (carrot #:amount-in-world 10)
                         (fish   #:amount-in-world 10))
    #:crafter-list (list (my-cauldron)))
  )

; sword, damage, has-gold? options (spear) fire-magic, etc
(define-example-code
  ;#:with-test (test game-test)
  adventure weapon-crafter-1
  (define my-sword-recipe
    (recipe #:product (sword)
            #:build-time 20))

  (adventure-game
    #:avatar       (basic-avatar)
    #:crafter-list (list (basic-crafter
                           #:sprite      woodtable-sprite
                           #:recipe-list (list my-sword-recipe))))
  )

(define-example-code
  ;#:with-test (test game-test)
  adventure weapon-crafter-2
  (define my-sword-recipe
    (recipe #:product (sword #:name "Heavy Sword"
                             #:damage 100)
            #:build-time 40))

  (adventure-game
    #:avatar       (basic-avatar)
    #:crafter-list (list (basic-crafter
                           #:sprite      woodtable-sprite
                           #:recipe-list (list my-sword-recipe))))
  )

(define-example-code
  ;#:with-test (test game-test)
  adventure weapon-crafter-3
  (define my-fire-magic-recipe
    (recipe #:product (fire-magic  #:name "Fire Magic"
                                   #:speed 5)
            #:build-time 60
            #:cost       100))

  (adventure-game
    #:avatar       (basic-avatar)
    #:coin-list    (list (basic-coin #:value 20
                                     #:amount-in-world 10))
    #:crafter-list (list (basic-crafter
                           #:sprite woodtable-sprite
                           #:recipe-list (list my-fire-magic-recipe))))
  )

; -----------------

(define-example-code
  ;#:with-test (test game-test)
  adventure sky-1 
  (adventure-game
    #:avatar (basic-avatar)
    #:sky    (basic-sky #:length-of-day 5000))
  )

(define-example-code
  ;#:with-test (test game-test)
  adventure sky-2 
  (adventure-game
    #:avatar (basic-avatar)
    #:sky    (basic-sky #:length-of-day 500
                        #:max-darkness  255))
  )

(define-example-code
  ;#:with-test (test game-test)
  adventure sky-3 
  (adventure-game
    #:avatar (basic-avatar)
    #:sky (basic-sky #:night-sky-color  'darkmagenta
                     #:max-darkness     150))
  )

(define-example-code
  ;#:with-test (test game-test)
  adventure sky-4 

  (adventure-game
    #:avatar       (basic-avatar)
    #:enemy-list   (list (basic-enemy #:amount-in-world 20
                                      #:night-only? #t))
    #:sky          (basic-sky #:length-of-day    2400
                              #:start-of-daytime 200
                              #:end-of-daytime   2200))
  )

; -----------------

(define-example-code
  ;#:with-test (test game-test)
  adventure food-1

  (adventure-game
    #:food-list  (list (basic-food #:sprite          apples-sprite
                                   #:name            "Apples"
                                   #:amount-in-world 10
                                   #:heals-by        20)))
  )

; Make a game with a 10 apples and a 1 cherry that heals by 50 that doesn't respawn
(define-example-code
  ;#:with-test (test game-test)
  adventure food-2

  (define my-food
    (basic-food #:sprite          apples-sprite
                #:name            "Apples"
                #:amount-in-world 10))

  (define special-food
    (basic-food #:sprite          cherry-sprite
                #:name            "Cherry"
                #:heals-by        50
                #:respawn?        #f))

  (adventure-game
    #:food-list  (list my-food
                       special-food))
  )

;Make a game with basic food and a rare food with a cutscene
(define-example-code
  ;#:with-test (test game-test)
  adventure food-3

  (define special-food
    (basic-food #:sprite          steak-sprite
                #:name            "Rare Steak"
                #:heals-by        100
                #:on-pickup (spawn (page (set-sprite-scale 2 steak-sprite)
                                         "This tastes raw ..."
                                         "maybe I should have cooked it."))))

  (adventure-game
    #:avatar (basic-avatar #:health 50
                           #:max-health 200)
    #:food-list  (list special-food))

  )

;Make a game with a food and crafter
(define-example-code
  ;#:with-test (test game-test)
  adventure food-4
  (define fish-stew
    (basic-food #:name "Fish Stew"
                #:sprite fishstew-sprite
                #:respawn? #f
                #:heals-by 50))

  (define fish-stew-recipe
    (recipe #:product fish-stew
            #:build-time 40
            #:ingredients (list "Fish")))

  (adventure-game
    #:food-list    (list (fish #:amount-in-world 10))
    #:crafter-list (list (basic-crafter #:recipe-list (list fish-stew-recipe))))
  )

; Make a game with a food, recipe, crafter, and npc with a craft quest
(define-example-code
  ;#:with-test (test game-test)
  adventure food-5

  (define carrot-stew
    (basic-food #:name "Carrot Stew"
                #:sprite carrotstew-sprite))

  (define my-carrot-stew-recipe
    (recipe #:product carrot-stew
            #:ingredients (list "Carrot")))

  (adventure-game
    #:npc-list     (list (basic-npc #:dialog (list "Can you make me some carrot stew?")
                                    #:quest-list (list (craft-quest #:item carrot-stew))))
    #:food-list    (list (carrot))
    #:crafter-list (list (basic-crafter #:recipe-list (list my-carrot-stew-recipe))))

  )

; -----------------

(define-example-code
  ;#:with-test (test game-test)
  adventure bg-1
  (adventure-game
    #:avatar (basic-avatar)
    #:bg (basic-bg))
  )

(define-example-code
  ;#:with-test (test game-test)
  adventure bg-2
  (adventure-game
    #:avatar (basic-avatar)
    #:bg (basic-bg #:image DESERT-BG))
  )

(define-example-code
  ;#:with-test (test game-test)
  adventure bg-3
  (define (my-bg)
    (basic-bg
      #:image LAVA-BG
      #:rows 2
      #:columns 2))

  (adventure-game
    #:avatar (basic-avatar)
    #:bg (my-bg))
  )

(define-example-code
  ;#:with-test (test game-test)
  adventure bg-4
  (define (my-bg)
    (basic-bg #:image LAVA-BG
              #:rows 2
              #:columns 2
              #:start-tile 3
              #:hd? #t))

  (adventure-game #:bg (my-bg))
  )


; ----- WEAPON KATAS
(define-example-code
  ;#:with-test (test game-test)
  adventure weapon-1
  (adventure-game
    #:weapon-list (list (spear #:name "Needle"
                               #:speed 15
                               #:damage 20
                               #:rarity 'rare)))
  )

(define-example-code
  ;#:with-test (test game-test)
  adventure weapon-2
  (define (my-sword)
    (sword #:damage 50
           #:rarity 'legendary))

  (define (my-repater)
    (repeater #:color 'red
              #:fire-mode 'spread))

  (adventure-game
    #:weapon-list (list (my-sword)
                        (my-repater))
    #:enemy-list (list (basic-enemy #:amount-in-world 5)))
  )

(define-example-code
  ;#:with-test (test game-test)
  adventure weapon-3
  (define (my-weapon)
    (repeater #:name "Hologram Shooter"
              #:icon (make-icon "?" 'red)
              #:sprite (random-character-sprite)
              #:speed 5
              #:damage 25
              #:range 50
              ))

  (adventure-game
    #:enemy-list (list (basic-enemy #:amount-in-world 5))
    #:weapon-list (list (my-weapon)))
  )

(define-example-code
  ;#:with-test (test game-test)
  adventure weapon-4
  (define (my-fire-magic)
    (fire-magic #:on-store (spawn (page "Ouch, this is hot!"))))

  (define (my-ice-magic)
    (ice-magic #:on-store (spawn (page "Woah, this is cold!"))))

  (adventure-game
    #:enemy-list (list (basic-enemy #:amount-in-world 10))
    #:weapon-list (list (my-fire-magic)
                        (my-ice-magic)))
  )

(define-example-code
  ;#:with-test (test game-test)
  adventure weapon-5
  (define (my-sword)
    (sword #:damage 50
           #:on-store (spawn (page (set-sprite-angle 45 swinging-sword-sprite)
                                   "I found a Sword!"))
           #:on-drop (spawn (page "Oh no! Better put it back in my backpack."))))

  (define (my-enemy)
    (basic-enemy #:sprite pirateboy-sprite
                 #:on-death (spawn (page (set-sprite-angle 90 (render pirateboy-sprite))
                                         "You won!"))))
  (adventure-game
    #:enemy-list (list (my-enemy))
    #:weapon-list (list (my-sword)))
  )

; ==============================




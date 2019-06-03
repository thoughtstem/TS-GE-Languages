#lang racket

(require ts-kata-util
         "./lang/main.rkt"
         adventure-harrypotter)

(define-example-code/from* adventure/examples)

; --------------- WIZARD

(define-example-code adventure-harrypotter alt/avatar-1
  (harrypotter-game
   #:wizard (basic-wizard
                #:sprite harrypotter-sprite
                #:speed  20))
  )


(define-example-code adventure-harrypotter alt/avatar-2
  (define (my-wizard)
    (basic-wizard
     #:sprite harrypotter-sprite
     #:speed  20
     #:health 200
     #:max-health 200))

  (harrypotter-game
   #:wizard (my-wizard))
  )

(define-example-code adventure-harrypotter alt/avatar-3
  (harrypotter-game
   #:wizard (basic-wizard
                #:sprite harrypotter-sprite
                #:speed  20)
   #:intro-cutscene (cutscene
                     (page harrypotter-sprite
                           "This is the story of"
                           "Harry Potter.")))
  )

(define-example-code adventure-harrypotter alt/avatar-4
  (harrypotter-game
   #:wizard (basic-wizard
                #:sprite harrypotter-sprite)
   #:intro-cutscene (basic-cutscene
                     (page "A long time ago,"
                           "In a magical place.")
                     (page harrypotter-sprite
                           "There was a young wizard"
                           "named Harry Potter.")))
  )

; --------------- POTION

(define-example-code adventure-harrypotter alt/food-1
 
  (harrypotter-game
   #:potion-list  (list (basic-potion #:name            "Heal Potion"
                                       #:amount-in-world 10
                                       #:heals-by        20)))
  )

(define-example-code adventure-harrypotter alt/food-2

  (define my-potion
    (basic-potion #:name            "Heal"
                   #:color           'green          
                   #:amount-in-world 10))

  (define special-potion
    (basic-potion #:name     "Ultra Heal"
                   #:color    'orange
                   #:heals-by 50
                   #:respawn? #f))

  (harrypotter-game
   #:potion-list  (list my-potion
                        special-potion))
  )

(define-example-code adventure-harrypotter alt/food-3
  (define special-potion
    (basic-potion  #:name      "Yellow Potion"
                   #:color     'yellow
                   #:heals-by  100
                   #:on-pickup (spawn (page (colorize-potion 'yellow)
                                            "This tastes bad ..."
                                            "Wow, I'm completely healed!"))))
                 
  (harrypotter-game
   #:wizard (basic-wizard #:health 100
                           #:max-health 200)
   #:potion-list  (list special-potion))
  
  )

(define-example-code adventure-harrypotter alt/food-4
  (define pumpkin-potion
    (basic-potion  #:name "Pumpkin Potion"
                   #:color 'orange
                   #:respawn? #f
                   #:heals-by 50))

  (define pumpkin-potion-recipe
    (recipe #:product "Pumpkin Potion"
            #:build-time 40
            #:ingredients (list "Pumpkin")))

  (harrypotter-game
   #:ingredient-list (list (pumpkin #:amount-in-world 10))
   #:cauldron-list   (list (basic-cauldron #:recipe-list (list pumpkin-potion-recipe))))
  )

(define-example-code adventure-harrypotter alt/food-5
  
  (define carrot-potion
    (basic-potion))

  (define carrot-potion-recipe
    (recipe #:product my-potion
            #:ingredients (list "Carrot")))

  (harrypotter-game
   #:npc-list     (list (basic-npc #:dialog (list "Can you make me a potion?")
                                    #:quest-list (list (craft-quest #:item my-potion))))
   #:ingredient-list    (list (carrot))
   #:cauldron-list (list (basic-cauldron #:recipe-list (list carrot-potion-recipe))))
  
  )

; --------------- LOOT-QUEST

(define-example-code adventure-harrypotter alt/loot-quest-3
  (define stolen-food
    (basic-food #:sprite apples-sprite))

  (harrypotter-game
   #:deatheater-list  (list (basic-deatheater #:loot-list (list stolen-food)))
   #:npc-list    (list (basic-npc #:dialog (list "Help! Someone stole my apples!")
                                   #:quest-list (list (loot-quest #:item stolen-food
                                                                  #:reward-amount 400))))
   #:spell-list (list (wand)))
  )

(define-example-code adventure-harrypotter alt/loot-quest-4

  (define stolen-pumpkin
    (pumpkin))
  
  (define my-loot-quest
    (loot-quest #:item stolen-pumpkin
                #:quest-complete-dialog (list "Thank you for finding my pumpkin!")))

  (harrypotter-game
   #:deatheater-list (list (basic-deatheater #:loot-list (list stolen-pumpkin)))
   #:npc-list   (list (basic-npc #:dialog (list "Help! Someone stole my pumpkin!")
                                  #:quest-list (list my-loot-quest)))
   #:spell-list (list (ice-magic)))
  )

(define-example-code adventure-harrypotter alt/loot-quest-5
  
  (define stolen-item
    (basic-item #:sprite  flyingbook-sprite
                 #:on-store (spawn (page flyingbook-sprite
                                         "This must be the stolen book."))))

  (harrypotter-game
   #:deatheater-list  (list (basic-deatheater #:loot-list (list stolen-item)))
   #:npc-list    (list (basic-npc #:dialog     (list "That thief took my book!")
                                   #:quest-list (loot-quest #:item stolen-item)
                                   ))
   #:spell-list (list (fire-magic)))
  )

; --------------- NPC

(define-example-code adventure-harrypotter alt/npc-5
  
  (define wand-quest
    (fetch-quest #:item (wand)
                 #:quest-complete-dialog (list "YAY! MY WAND!")
                 #:new-response-dialog (list "Thanks again!")))

  (adventure-game
   #:avatar (basic-avatar #:components player-dialog-with-charlie)
   #:npc-list (list (basic-npc  #:name "Charlie"
                                #:dialog (list "Can you find my wand?")
                                #:quest-list (list wand-quest))))
  )

; --------------- SPELLS
(define-example-code adventure-harrypotter alt/weapon-1
  (harrypotter-game
   #:spell-list (list (wand #:name "Phoenix Feather"
                            #:icon (make-icon "PHX")
                            #:damage 40
                            #:rarity 'rare)))
  )

(define-example-code adventure-harrypotter alt/weapon-2
  (define (my-wand)
    (wand  #:damage 50
           #:rarity 'legendary))
  
  (define (my-spell)
    (basic-spell  #:name "Fire Darts"
                  #:color 'red
                  #:fire-mode 'spread))
  
  (harrypotter-game
   #:spell-list (list (my-wand)
                      (my-spell))
   #:deatheater-list (list (basic-deatheater #:amount-in-world 5)))
  )

(define-example-code adventure-harrypotter alt/weapon-3
  (define (my-spell)
    (basic-spell   #:name "Expecto Patronum"
                   #:icon (make-icon "?" 'red)
                   #:sprite (cat-sprite)
                   #:speed 5
                   #:damage 25
                   #:range 50
                   ))
  
  (harrypotter-game
   #:wizard (basic-wizard)
   #:deatheater-list (list (basic-deatheater #:amount-in-world 5))
   #:spell-list (list (my-spell)))
  )

(define-example-code adventure-harrypotter alt/weapon-5
  (define (my-wand)
    (wand #:damage 50
          #:on-store (spawn (page swinging-wand-sprite
                                  "I found a Wand!"))
          #:on-drop (spawn (page "Oh no! Better put it back in my backpack."))))

  (define (my-baddy)
    (basic-deatheater #:sprite snape-sprite
                      #:on-death (spawn (page (set-sprite-angle 90 (render snape-sprite))
                                          "You won!"))))
  (harrypotter-game
   #:deatheater-list (list (my-baddy))
   #:spell-list (list (my-wand)))
  )

;We'll test that the examples all run as games for 10 ticks
(test-all-examples-as-games 'adventure-harrypotter)
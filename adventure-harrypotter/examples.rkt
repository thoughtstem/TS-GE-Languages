#lang racket

(require ts-kata-util
         "./lang/main.rkt"
         adventure-harrypotter)

(define-example-code/from* adventure/examples)

; --------------- WIZARD

(define-example-code adventure-harrypotter alt/avatar-1
  (harrypotter-game
   #:wizard (custom-wizard
                #:sprite harrypotter-sprite
                #:speed  20))
  )


(define-example-code adventure-harrypotter alt/avatar-2
  (define (my-wizard)
    (custom-wizard
     #:sprite harrypotter-sprite
     #:speed  20
     #:health 200
     #:max-health 200))

  (harrypotter-game
   #:wizard (my-wizard))
  )

(define-example-code adventure-harrypotter alt/avatar-3
  (harrypotter-game
   #:wizard (custom-wizard
                #:sprite harrypotter-sprite
                #:speed  20)
   #:intro-cutscene (custom-cutscene
                     (page harrypotter-sprite
                           "This is the story of"
                           "Harry Potter.")))
  )

(define-example-code adventure-harrypotter alt/avatar-4
  (harrypotter-game
   #:wizard (custom-wizard
                #:sprite harrypotter-sprite)
   #:intro-cutscene (custom-cutscene
                     (page "A long time ago,"
                           "In a magical place.")
                     (page harrypotter-sprite
                           "There was a young wizard"
                           "named Harry Potter.")))
  )

; --------------- POTION

(define-example-code adventure-harrypotter alt/food-1
 
  (harrypotter-game
   #:potion-list  (list (custom-potion #:name            "Heal Potion"
                                       #:amount-in-world 10
                                       #:heals-by        20)))
  )

(define-example-code adventure-harrypotter alt/food-2

  (define my-potion
    (custom-potion #:name            "Heal"
                   #:color           'green          
                   #:amount-in-world 10))

  (define special-potion
    (custom-potion #:name     "Ultra Heal"
                   #:color    'orange
                   #:heals-by 50
                   #:respawn? #f))

  (harrypotter-game
   #:potion-list  (list my-potion
                        special-potion))
  )

(define-example-code adventure-harrypotter alt/food-3
  (define special-potion
    (custom-potion #:name      "Yellow Potion"
                   #:sprite    (colorize-potion 'yellow)
                   #:heals-by  100
                   #:on-pickup (spawn (page (colorize-potion 'yellow)
                                            "This tastes bad ..."
                                            "Wow, I'm completely healed!"))))
                 
  (harrypotter-game
   #:wizard (custom-wizard #:health 100
                           #:max-health 200)
   #:potion-list  (list special-potion))
  
  )

(define-example-code adventure-harrypotter alt/food-4
  (define fish-potion
    (custom-potion #:name "Fish Potion"
                   #:respawn? #f
                   #:heals-by 50))

  (define fish-potion-recipe
    (recipe #:product fish-potion
            #:build-time 40
            #:ingredients (list "Fish")))

  (harrypotter-game
   #:ingredient-list (list (fish #:amount-in-world 10))
   #:cauldron-list   (list (custom-cauldron #:recipe-list (list fish-potion-recipe))))
  )

(define-example-code adventure-harrypotter alt/food-5
  
  (define my-potion
    (custom-potion))

  (define carrot-potion-recipe
    (recipe #:product my-potion
            #:ingredients (list "Carrot")))

  (harrypotter-game
   #:npc-list     (list (custom-npc #:dialog (list "Can you make me a potion?")
                                    #:quest-list (list (craft-quest #:item my-potion))))
   #:ingredient-list    (list (carrot))
   #:cauldron-list (list (custom-cauldron #:recipe-list (list carrot-potion-recipe))))
  
  )

; --------------- LOOT-QUEST

(define-example-code adventure-harrypotter alt/loot-quest-3
  (define stolen-food
    (custom-food #:sprite apples-sprite))

  (harrypotter-game
   #:deatheater-list  (list (custom-deatheater #:loot-list (list stolen-food)))
   #:npc-list    (list (custom-npc #:dialog (list "Help! Someone stole my apples!")
                                   #:quest-list (list (loot-quest #:item stolen-food
                                                                  #:reward-amount 400))))
   #:spell-list (list (repeater)))
  )

(define-example-code adventure-harrypotter alt/loot-quest-4

  (define stolen-pumpkin
    (custom-item #:sprite pumpkin-sprite))
  
  (define my-loot-quest
    (loot-quest #:item stolen-pumpkin
                #:quest-complete-dialog (list "Thank you for finding my pumpkin!")))

  (harrypotter-game
   #:deatheater-list (list (custom-deatheater #:loot-list (list stolen-pumpkin)))
   #:npc-list   (list (custom-npc #:dialog (list "Help! Someone stole my pumpkin!")
                                  #:quest-list (list my-loot-quest)))
   #:spell-list (list (ice-magic)))
  )

(define-example-code adventure-harrypotter alt/loot-quest-5
  
  (define stolen-item
    (custom-item #:sprite  flyingbook-sprite
                 #:on-store (spawn (page flyingbook-sprite
                                         "This must be the stolen book."))))

  (harrypotter-game
   #:deatheater-list  (list (custom-deatheater #:loot-list (list stolen-item)))
   #:npc-list    (list (custom-npc #:dialog     (list "That thief took my book!")
                                   #:quest-list (loot-quest #:item stolen-item)
                                   ))
   #:spell-list (list (fire-magic)))
  )

; --------------- NPC

; --------------- SPELLS
(define-example-code adventure-harrypotter alt/weapon-1
  (harrypotter-game
   #:spell-list (list (wand #:name "Phoenix Feather"
                           #:speed 15
                           #:damage 20
                           #:rarity 'rare)))
  )

(define-example-code adventure-harrypotter alt/weapon-2
  (define (my-wand)
    (wand #:damage 50
           #:rarity 'legendary))
  
  (define (my-spell)
    (custom-spell #:name "Fire Darts"
                  #:color 'red
                  #:fire-mode 'spread))
  
  (harrypotter-game
   #:spell-list (list (my-wand)
                      (my-spell))
   #:deatheater-list (list (custom-deatheater #:amount-in-world 5)))
  )

(define-example-code adventure-harrypotter alt/weapon-3
  (define (my-spell)
    (custom-spell #:name "Hologram Shooter"
                   #:sprite (make-icon "?" 'red)
                   #:dart-sprite (random-character-sprite)
                   #:speed 5
                   #:damage 25
                   #:range 50
                   ))
  
  (harrypotter-game
   #:wizard (custom-wizard)
   #:deatheater-list (list (custom-deatheater #:amount-in-world 5))
   #:spell-list (list (my-spell)))
  )

(define-example-code adventure-harrypotter alt/weapon-5
  (define (my-wand)
    (wand #:damage 50
          #:on-store (spawn (page swinging-wand-sprite
                                  "I found a Wand!"))
          #:on-drop (spawn (page "Oh no! Better put it back in my backpack."))))

  (define (my-baddy)
    (custom-deatheater #:sprite pirateboy-sprite
                  #:on-death (spawn (page (set-sprite-angle 90 (render pirateboy-sprite))
                                          "You won!"))))
  (harrypotter-game
   #:deatheater-list (list (my-baddy))
   #:spell-list (list (my-wand)))
  )

;We'll test that the examples all run as games for 10 ticks
(test-all-examples-as-games 'adventure-harrypotter)
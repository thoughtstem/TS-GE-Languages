#lang racket

(require ts-kata-util
         "./lang/main.rkt"
         (except-in adventure-mario custom-npc custom-enemy))

(define-example-code/from* adventure/examples)

; ---------------

(define-example-code adventure-mario alt/avatar-1
  (mario-game
   #:character (custom-character
                #:sprite mario-sprite
                #:speed  20))
  )


(define-example-code adventure-mario alt/avatar-2
  (define (my-character)
    (custom-character
     #:sprite luigi-sprite
     #:speed  20
     #:health 200
     #:max-health 200))

  (mario-game
   #:character (my-character))
  )

(define-example-code adventure-mario alt/avatar-3
  (mario-game
   #:character (custom-character
                #:sprite princesspeach-sprite
                #:speed  20)
   #:intro-cutscene (custom-cutscene
                     (page princesspeach-sprite
                           "This is the story of"
                           "Princess Peach.")))
  )

(define-example-code adventure-mario alt/avatar-4
  (mario-game
   #:character (custom-character
                #:sprite toad-sprite)
   #:intro-cutscene (custom-cutscene
                     (page "A long time ago,"
                           "In a magical place.")
                     (page toad-sprite
                           "There was a mushroom man"
                           "named Toad.")))
  )

; ---------------

(define-example-code adventure-mario alt/level-design-3
  (mario-game
   #:level           (custom-level
                      #:image FOREST-BG
                      #:hd? #t)
   #:other-entities (make-world-objects fence
                                        brick
                                        #:hd? #t)) 
  )

(define-example-code adventure-mario alt/level-design-4

  (mario-game
   #:character (custom-character
                #:sprite bigmario1-sprite)
   #:level          (custom-level
                     #:image DESERT-BG)
   #:intro-cutscene (custom-cutscene
                     (page "Once upon a time"
                           "There was a lone plumber")
                     (page bigmario1-sprite
                           "This is his story."))
   #:other-entities (make-world-objects block
                                        pipe
                                        #:hd? #t))
  )

(define-example-code adventure-mario alt/level-design-5
  
  (mario-game
   #:other-entities (question-block (posn 100 200) #:tile 1 #:size 2)
                    (brick-house    (posn 200 200) #:tile 2 #:hue (random 360))
                    (reduce-quality-by 2 (pipe (posn 100 200) #:tile 0))
                    )
  )

; -------------------------

(define-example-code adventure-mario alt/fetch-quest-1
  (define lost-yoshi
    (custom-npc
     #:name "Yoshi"
     #:sprite yoshi1-sprite))
  
  (mario-game
   #:npc-list (list
               (custom-npc
                #:dialog (list
                          "Please help me find Yoshi!")
                #:quest-list (list
                              (fetch-quest
                               #:item lost-yoshi)))))
  )

(define-example-code adventure-mario alt/fetch-quest-2
  (define lost-cheep
    (custom-npc
     #:sprite cheep3-sprite))

  (define my-cutscene
    (custom-cutscene
     (page
      cheep3-sprite
      "Happy to be home!")))
  
  (mario-game
   #:npc-list (list
               (custom-npc
                     #:dialog (list
                               "Please help me find my cheep!")
                     #:quest-list (list
                                   (fetch-quest
                                    #:item lost-cheep
                                    #:cutscene my-cutscene)))))
  )

(define-example-code adventure-mario alt/fetch-quest-3  
  (define fetch-quest-1
    (fetch-quest
     #:item (custom-item
             #:name "Red Mushroom"
             #:sprite redmushroom-sprite)))
  
  (define fetch-quest-2
    (fetch-quest
     #:item (custom-item
             #:name "Green Mushroom"
             #:sprite greenmushroom-sprite)
     #:reward-amount 500))

  (mario-game
   #:npc-list (list
               (custom-npc
                #:dialog (list "Can you help me?"
                               "I dropped my mushrooms?")
                #:quest-list (list fetch-quest-1
                                   fetch-quest-2))))
  )

(define-example-code adventure-mario alt/fetch-quest-4  
  (define my-fetch-quest
    (fetch-quest #:item (custom-item
                         #:sprite goomba1-sprite)
                 #:quest-complete-dialog (list "Thank you!")
                 #:new-response-dialog   (list "Thanks again!")
                 #:reward-amount 400 ))

  (mario-game
   #:npc-list (list (custom-npc
                     #:dialog (list "Can you help me?"
                                    "I can't find Goomba")
                     #:quest-list (list my-fetch-quest))))
  )

(define-example-code adventure-mario alt/fetch-quest-5  
  (define my-quest-item
    (custom-item
     #:sprite  spiny3-sprite
     #:on-store (spawn
                 (page spiny3-sprite
                       "This must be Lakitu's pet."))
     #:on-drop  (spawn
                 (page "Maybe I shouldn't drop it.")
                 #:rule (not/r
                         (entity-in-game?
                          "Lakitu")))))

  (mario-game
   #:npc-list (list
               (custom-npc
                #:name       "Lakitu"
                #:sprite     lakitu3-sprite
                #:dialog     (list "Can you help me find my pet?")
                #:quest-list (fetch-quest
                              #:item my-quest-item
                              #:reward-amount 500
                              #:cutscene (page
                                          spiny3-sprite
                                          "Spiny, I've missed you!")))))
  )

; -----------------

(define-example-code adventure-mario alt/enemy-2
  (define (easy-enemy)
    (custom-enemy #:ai              'easy
                  #:sprite          goomba1-sprite
                  #:amount-in-world 4))
  
  (define (medium-enemy)
    (custom-enemy #:ai              'medium
                  #:sprite          piranha2-sprite
                  #:amount-in-world 2))

  (define (hard-enemy)
    (custom-enemy #:ai          'hard
                  #:sprite      bowser3-sprite
                  #:night-only? #t))
 
  (mario-game
   #:enemy-list (list (easy-enemy)
                      (medium-enemy)
                      (hard-enemy)))
  )

(define-example-code adventure-mario alt/enemy-4
  (define (hard-enemy)
    (custom-enemy #:amount-in-world 3
                  #:ai 'hard
                  #:weapon (fireball)))

  (define game-over-sprite
    (set-sprite-angle
     90
     (render princesspeach-sprite)))
                                           
  (mario-game
   #:character          (custom-character
                         #:sprite princesspeach-sprite)
   #:game-over-cutscene (custom-cutscene (page game-over-sprite
                                               "You died!"))
   #:power-list (list (spear))
   #:enemy-list  (list (hard-enemy)))
  )

;We'll test that the examples all run as games for 10 ticks
(test-all-examples-as-games 'adventure-mario)
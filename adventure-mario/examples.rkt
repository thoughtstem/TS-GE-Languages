#lang racket

(require ts-kata-util
         "./lang/main.rkt"
         (except-in adventure-mario basic-npc basic-enemy))

(define-example-code/from* adventure/examples)

; ---------------

(define-example-code 
  #:with-test (test game-test)
  adventure-mario alt/avatar-1
  (mario-game
   #:character (basic-character
                #:sprite mario-sprite
                #:speed  20))
  )


(define-example-code
  #:with-test (test game-test) adventure-mario alt/avatar-2
  (define (my-character)
    (basic-character
     #:sprite luigi-sprite
     #:speed  20
     #:health 200
     #:max-health 200))

  (mario-game
   #:character (my-character))
  )

(define-example-code
  #:with-test (test game-test) adventure-mario alt/avatar-3
  (mario-game
   #:character (basic-character
                #:sprite princesspeach-sprite
                #:speed  20)
   #:intro-cutscene (basic-cutscene
                     (page princesspeach-sprite
                           "This is the story of"
                           "Princess Peach.")))
  )

(define-example-code
  #:with-test (test game-test) adventure-mario alt/avatar-4
  (mario-game
   #:character (basic-character
                #:sprite toad-sprite)
   #:intro-cutscene (basic-cutscene
                     (page "A long time ago,"
                           "In a magical place.")
                     (page toad-sprite
                           "There was a mushroom man"
                           "named Toad.")))
  )

; ---------------

(define-example-code
  #:with-test (test game-test) adventure-mario alt/level-design-3
  (mario-game
   #:level           (basic-level
                      #:image FOREST-BG
                      #:hd? #t)
   #:other-entities (make-world-objects fence
                                        brick
                                        #:hd? #t)) 
  )

(define-example-code
  #:with-test (test game-test) adventure-mario alt/level-design-4

  (mario-game
   #:character (basic-character
                #:sprite bigmario-sprite)
   #:level          (basic-level
                     #:image DESERT-BG)
   #:intro-cutscene (basic-cutscene
                     (page "Once upon a time"
                           "there was a lone plumber.")
                     (page bigmario-sprite
                           "This is his story."))
   #:other-entities (make-world-objects block
                                        pipe
                                        #:hd? #t))
  )

(define-example-code
  #:with-test (test game-test) adventure-mario alt/level-design-5
  
  (mario-game
   #:other-entities (question-block (posn 100 200) #:tile 1 #:size 2)
                    (brick-house    (posn 200 200) #:tile 2 #:hue (random 360))
                    (reduce-quality-by 2 (pipe (posn 100 200) #:tile 0))
                    )
  )

; -------------------------

(define-example-code
  #:with-test (test game-test) adventure-mario alt/fetch-quest-1
  (define lost-yoshi
    (basic-npc
     #:name "Yoshi"
     #:sprite yoshi-sprite))
  
  (mario-game
   #:npc-list (list
               (basic-npc
                #:dialog (list
                          "Please help me find Yoshi!")
                #:quest-list (list
                              (fetch-quest
                               #:item lost-yoshi)))))
  )

(define-example-code
  #:with-test (test game-test) adventure-mario alt/fetch-quest-2
  (define lost-cheep
    (basic-npc
     #:sprite orangecheep-sprite))

  (define my-cutscene
    (basic-cutscene
     (page
      orangecheep-sprite
      "Happy to be home!")))
  
  (mario-game
   #:npc-list (list
               (basic-npc
                     #:dialog (list
                               "Please help me find my cheep!")
                     #:quest-list (list
                                   (fetch-quest
                                    #:item lost-cheep
                                    #:cutscene my-cutscene)))))
  )

(define-example-code
  #:with-test (test game-test) adventure-mario alt/fetch-quest-3  
  (define fetch-quest-1
    (fetch-quest
     #:item (basic-item
             #:name "Red Mushroom"
             #:sprite redmushroom-sprite)))
  
  (define fetch-quest-2
    (fetch-quest
     #:item (basic-item
             #:name "Green Mushroom"
             #:sprite greenmushroom-sprite)
     #:reward-amount 500))

  (mario-game
   #:npc-list (list
               (basic-npc
                #:dialog (list "Can you help me?"
                               "I dropped my mushrooms?")
                #:quest-list (list fetch-quest-1
                                   fetch-quest-2))))
  )

(define-example-code
  #:with-test (test game-test) adventure-mario alt/fetch-quest-4  
  (define my-fetch-quest
    (fetch-quest #:item (basic-item
                         #:sprite goomba-sprite)
                 #:quest-complete-dialog (list "Thank you!")
                 #:new-response-dialog   (list "I <3 Goomba!")
                 #:reward-amount 400 ))

  (mario-game
   #:npc-list (list (basic-npc
                     #:dialog (list "Can you help me?"
                                    "I can't find Goomba")
                     #:quest-list (list my-fetch-quest))))
  )

(define-example-code
  #:with-test (test game-test) adventure-mario alt/fetch-quest-5  
  (define my-quest-item
    (basic-item
     #:sprite  bluespiny-sprite
     #:on-store (spawn
                 (page bluespiny-sprite
                       "This must be Lakitu's pet."))
     #:on-drop  (spawn
                 (page "Maybe I shouldn't drop it.")
                 #:rule (not/r
                         (entity-in-game?
                          "Lakitu")))))

  (mario-game
   #:npc-list (list
               (basic-npc
                #:name       "Lakitu"
                #:sprite     greylakitu-sprite
                #:dialog     (list "Can you help me find my pet?")
                #:quest-list (fetch-quest
                              #:item my-quest-item
                              #:reward-amount 500))))
  )

; -----------------

(define-example-code
  #:with-test (test game-test) adventure-mario alt/enemy-2
  (define (easy-enemy)
    (basic-enemy #:ai              'easy
                  #:sprite          goomba-sprite
                  #:amount-in-world 4))
  
  (define (medium-enemy)
    (basic-enemy #:ai              'medium
                  #:sprite          bluepiranha-sprite
                  #:amount-in-world 2))

  (define (hard-enemy)
    (basic-enemy #:ai          'hard
                  #:sprite      orangebowser-sprite
                  #:night-only? #t))
 
  (mario-game
   #:enemy-list (list (easy-enemy)
                      (medium-enemy)
                      (hard-enemy)))
  )

(define-example-code
  #:with-test (test game-test) adventure-mario alt/enemy-4
  (define (hard-enemy)
    (basic-enemy  #:amount-in-world 3
                  #:ai 'hard
                  #:weapon (fireball)))

  (define game-over-sprite
    (set-sprite-angle
     90
     (render princesspeach-sprite)))
                                           
  (mario-game
   #:character          (basic-character
                         #:sprite princesspeach-sprite)
   #:game-over-cutscene (basic-cutscene (page game-over-sprite
                                               "You died!"))
   #:power-list (list (spear))
   #:enemy-list  (list (hard-enemy)))
  )


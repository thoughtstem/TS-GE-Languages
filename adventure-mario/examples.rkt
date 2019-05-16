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
                           "on a volcanic moon.")
                     (page "There was a lone plumber")
                     (page (set-sprite-scale 2 bigmario1-sprite)
                           "This is his story."))
   #:other-entities (make-world-objects block
                                        pipe
                                        #:hd? #t))
  )

(define-example-code adventure-mario alt/level-design-5
  
  (mario-game
   #:level          (custom-level)
   #:character      (custom-character)
   #:other-entities (reduce-quality-by 2 (pipe (posn 100 200) #:tile 0))
   (question-block (posn 100 200) #:tile 1 #:size 2)
   (brick-house    (posn 200 200) #:tile 2 #:hue (random 360)))
  )

; -------------------------

(define-example-code adventure-mario alt/fetch-quest-1
  (define lost-yoshi
    (custom-npc #:name "Yoshi"
                #:sprite yoshi1-sprite))
  
  (mario-game
   #:npc-list (list (custom-npc
                     #:dialog (list "Can you help me find my Yoshi?"
                                    "I've looked everywhere!")
                     #:quest-list (list (fetch-quest
                                         #:item lost-yoshi)))))
  )

(define-example-code adventure-mario alt/fetch-quest-2
  (define lost-cheep
    (custom-npc #:name "Cheep"
                #:sprite cheep3-sprite))

  (define my-cutscene
    (custom-cutscene (page (set-sprite-scale 2 cheep3-sprite)
                           "Cheep is happy to be home!")))
  
  (mario-game
   #:npc-list (list (custom-npc
                     #:dialog (list "Can you help me find Cheep?")
                     #:quest-list (list (fetch-quest
                                         #:item lost-cheep
                                         #:cutscene my-cutscene)))))
  )

(define-example-code adventure-mario alt/fetch-quest-3  
  (define fetch-quest-1
    (fetch-quest #:item (custom-item
                         #:name "Red Mushroom"
                         #:sprite redmushroom-sprite)
                 #:reward-amount 200))
  
  (define fetch-quest-2
    (fetch-quest #:item (custom-item
                         #:name "Green Mushroom"
                         #:sprite greenmushroom-sprite)
                 #:reward-amount 500))

  (mario-game
   #:npc-list (list (custom-npc
                     #:sprite toad-sprite
                     #:dialog (list "Can you help me find my mushrooms?"
                                    "I'll give you a reward for each one.")
                     #:quest-list (list fetch-quest-1
                                        fetch-quest-2))))
  )

(define-example-code adventure-mario alt/fetch-quest-4  
  (define my-fetch-quest
    (fetch-quest #:item (custom-item
                         #:name "Goomba"
                         #:sprite goomba1-sprite)
                 #:quest-complete-dialog (list "Thank you for finding Goomba!")
                 #:new-response-dialog   (list "Thanks again for your help.")
                 #:reward-amount 400 ))

  (mario-game
   #:npc-list (list (custom-npc
                     #:name "Bowser"
                     #:sprite bowser3-sprite
                     #:dialog (list "Can you help me find my Goomba?")
                     #:quest-list (list my-fetch-quest))))
  )

(define-example-code adventure-mario alt/fetch-quest-5  
  (define my-quest-item
    (custom-item #:name "Spiny"
                 #:sprite  spiny3-sprite
                 #:on-store (spawn (page (set-sprite-scale 2 spiny3-sprite)
                                         "This must be Lakitu's lost Spiny"))
                 #:on-drop  (spawn (page "Maybe I shouldn't leave him"
                                         "alone like this.")
                                   #:rule (not/r (entity-in-game? "Lakitu")))))

  (mario-game
   #:npc-list (list (custom-npc
                     #:name "Lakitu"
                     #:sprite     lakitu3-sprite
                     #:dialog     (list "Can you help me find my Spiny?")
                     #:quest-list (fetch-quest
                                   #:item my-quest-item
                                   #:reward-amount 500
                                   #:cutscene (page (list (set-sprite-x-offset -50 lakitu3-sprite)
                                                          (set-sprite-x-offset 50 spiny3-sprite))
                                                    "Spiny, I've missed you!"))
                     )))
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
  (define (easy-enemy)
    (custom-enemy #:amount-in-world 5))

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
                                               "You died!")
                                         (page "Try harder!"))
   #:power-list (list (spear))
   #:enemy-list  (list (easy-enemy)
                       (hard-enemy)))
  )

;We'll test that the examples all run as games for 10 ticks
(test-all-examples-as-games 'adventure-mario)
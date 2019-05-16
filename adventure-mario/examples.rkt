#lang racket

(require ts-kata-util
         "./lang/main.rkt"
         adventure-mario)

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

 ;Make a game with a basic fetch quest
#|(define-example-code adventure-mario alt/fetch-quest-1
  (define lost-toad
    (custom-item #:name "Toad"
                 #:sprite toad-sprite))
  
  (mario-game
   #:npc-list (list (custom-npc #:dialog (list "Can you help me find Toad?"
                                               "I've looked everywhere!")
                                #:quest-list (list (fetch-quest #:item lost-toad)))))
  )

(define-example-code adventure-mario alt/fetch-quest-2
  (define lost-cat
    (custom-item #:name "Mylo"
                 #:sprite cat-sprite))

  (define my-cutscene
    (custom-cutscene (page (set-sprite-scale 2 cat-sprite)
                           "Mylo is happy to be home!")))
  
  (mario-game
   #:npc-list (list (custom-npc #:dialog (list "Can you help me find my cat?")
                                #:quest-list (list (fetch-quest #:item lost-cat
                                                                #:cutscene my-cutscene)))))
  )

(define-example-code adventure-mario alt/fetch-quest-3
  
  (define fetch-quest-1
    (fetch-quest #:item (custom-item #:name "Mylo"
                                     #:sprite cat-sprite)
                 #:reward-amount 200))
  
  (define fetch-quest-2
    (fetch-quest #:item (custom-item #:name "Buttons"
                                     #:sprite white-cat-sprite)
                 #:reward-amount 200))

  (mario-game
   #:npc-list (list (custom-npc #:name "Erin"
                                #:sprite lightelf-sprite
                                #:dialog (list "Can you help me find my cats?"
                                               "I'll give you a reward for each cat.")
                                #:quest-list (list fetch-quest-1
                                                   fetch-quest-2))))
  )

(define-example-code adventure-mario alt/fetch-quest-4
  
  (define my-fetch-quest
    (fetch-quest #:item (custom-item #:name "Mylo"
                                     #:sprite cat-sprite)
                 #:quest-complete-dialog (list "Thank you for finding Mylo!")
                 #:new-response-dialog   (list "Thanks again for your help.")
                 #:reward-amount 400 ))

  (mario-game
   #:npc-list (list (custom-npc #:name "Erin"
                                #:sprite lightelf-sprite
                                #:dialog (list "Can you help me find my cat?")
                                #:quest-list (list my-fetch-quest))))
  )

(define-example-code adventure-mario alt/fetch-quest-5
  
  (define my-quest-item
    (custom-item #:name "Mylo"
                 #:sprite  cat-sprite
                 #:on-store (spawn (page (set-sprite-scale 2 cat-sprite)
                                         "This must be Erin's lost cat"))
                 #:on-drop  (spawn (page "Maybe I shouldn't leave him"
                                         "alone like this.")
                                   #:rule (not/r (entity-in-game? "Erin")))))

  (mario-game
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
|#
;We'll test that the examples all run as games for 10 ticks
(test-all-examples-as-games 'adventure-mario)
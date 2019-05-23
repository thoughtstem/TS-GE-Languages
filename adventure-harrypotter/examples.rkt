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

; --------------- CRAFTING

; --------------- LOOT-QUEST

; --------------- NPC

; --------------- WANDS


;We'll test that the examples all run as games for 10 ticks
(test-all-examples-as-games 'adventure-harrypotter)
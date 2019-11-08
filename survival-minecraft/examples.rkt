#lang racket

(require ts-kata-util
         "./lang/main.rkt"
         ;"./assets.rkt"
         )

(define-example-code/from* survival/examples)

;=================================

(define-example-code 
  ;#:with-test (test game-test)
  survival-minecraft alt/avatar-2
  (minecraft-game
    #:skin (basic-skin #:sprite alex-sprite)))

(define-example-code
  ;#:with-test (test game-test)
  survival-minecraft alt/avatar-3
  (define (my-hero)
    (basic-skin #:sprite monk-sprite))

  (minecraft-game
    #:skin (reduce-quality-by 3 (my-hero))))

(define-example-code
  ;#:with-test (test game-test)
  survival-minecraft alt/avatar-4
  (define (my-hero)
    (basic-skin #:sprite alex-sprite
                #:speed 20))

  (minecraft-game
    #:skin (my-hero)))

(define-example-code
  ;#:with-test (test game-test)
  survival-minecraft alt/avatar-5
  (define (my-hero)
    (basic-skin #:sprite alex-sprite
                #:speed 20
                #:key-mode 'wasd))

  (minecraft-game
    #:skin (my-hero)))

(define-example-code
  ;#:with-test (test game-test)
  survival-minecraft avatar-6

  (define (my-hero)
    (basic-skin
      #:sprite pig-sprite
      #:speed 20
      #:key-mode 'wasd
      #:health 200
      #:max-health 200))

  (minecraft-game #:skin (my-hero)))


;======================================================

(define-example-code
  ;#:with-test (test game-test)
  survival-minecraft alt/enemy-3  
  (define (my-mob)
    (basic-mob #:ai 'medium
               #:sprite skeleton-sprite
               #:amount-in-world 5))

  (minecraft-game
    #:mob-list (list (my-mob)))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival-minecraft alt/enemy-4
  (define (easy-mob)
    (basic-mob #:ai 'easy
               #:sprite creeper-sprite
               #:amount-in-world 5))

  (define (medium-mob)
    (basic-mob #:ai 'medium
               #:sprite skeleton-sprite
               #:amount-in-world 5
               #:night-only? #t))

  (minecraft-game
    #:mob-list (list (easy-mob) (medium-mob)))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival-minecraft alt/enemy-5 
  (define (medium-mob)
    (basic-mob #:ai 'medium
               #:sprite skeleton-sprite
               #:amount-in-world 3
               ))

  (define (hard-mob)
    (basic-mob #:ai              'hard
               #:sprite          ghast-sprite
               #:amount-in-world 5
               #:night-only?     #t
               #:weapon          (fireball #:damage 50)))

  (minecraft-game
    #:mob-list (list (medium-mob)
                     (hard-mob)))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival-minecraft alt/enemy-6

  (define (hard-mob)
    (basic-mob #:ai              'hard
               #:sprite          ghast-sprite
               #:amount-in-world 5
               #:weapon          (acid-spitter #:damage 50)))

  (minecraft-game
    #:mob-list (list (hard-mob)))
  )

;=============================================


(define-example-code
  ;#:with-test (test game-test)
  survival-minecraft alt/coin-2
  (minecraft-game
    #:ore-list (list (basic-ore #:value 50)))
  )

(define-example-code 
  ;#:with-test (test game-test)
  survival-minecraft alt/coin-3 
  (define (my-ore)
    (basic-ore #:sprite goldore-sprite
               #:name "Gold Ore"
               #:value 200
               #:amount-in-world 20))

  (minecraft-game
    #:ore-list (list (my-ore)))
  )

(define-example-code 
  ;#:with-test (test game-test)
  survival-minecraft alt/coin-4 
  (define (gold-ore)
    (basic-ore #:sprite goldore-sprite
               #:name   "Gold Ore"))

  (define (diamond)
    (basic-ore #:sprite          diamond-sprite
               #:name            "Diamond"
               #:value           1000
               #:amount-in-world 1
               #:respawn?        #f))

  (minecraft-game
    #:ore-list (list (gold-ore)
                     (diamond)))
  )

(define-example-code 
  ;#:with-test (test game-test)
  survival-minecraft alt/coin-5   
  (define (diamond)
    (basic-ore #:sprite           diamond-sprite
               #:name            "Diamond"
               #:value           500
               #:amount-in-world 5))

  (define (mesecrystal)
    (basic-ore #:sprite           mesecrystal-sprite
               #:name            "Mese Crystal"
               #:value           1000
               #:amount-in-world 1
               #:respawn?        #f))

  (minecraft-game
    #:ore-list (list (diamond)
                     (mesecrystal)))
  )
;=========================================================

#;(define-example-code 
;#:with-test (test game-test)
survival-minecraft alt/npc-2 
(define (my-entity)
  (basic-entity
    #:sprite pig-sprite
    #:name "Miss Piggy"))

(minecraft-game
  #:entity-list (list (my-entity))))

(define-example-code 
  ;#:with-test (test game-test)
  survival-minecraft alt/npc-3 
  (define (my-entity)
    (basic-entity
      #:sprite pig-sprite
      #:name "Sir Pigsnoot"
      #:tile 3
      #:mode 'follow))

  (minecraft-game
    #:entity-list (list (my-entity))))

(define-example-code 
  ;#:with-test (test game-test)
  survival-minecraft alt/npc-4 
  (define (my-entity)
    (basic-entity
      #:dialog (list "Woah, who are you??"
                     "Wait, I'm a chicken..."
                     "I can't talk!")))
  (minecraft-game
    #:entity-list (list (my-entity))))

(define-example-code 
  ;#:with-test (test game-test)
  survival-minecraft alt/npc-5 
  (define (my-entity)
    (basic-entity
      #:name "Francis"
      #:tile 4
      #:dialog (list "Greetings!"
                     "Gee, you look hungry.")))

  (define (another-entity)
    (basic-entity
      #:sprite chicken-sprite
      #:name "Mr. Chick Chickenson III"
      #:mode 'pace
      #:dialog (list "Woah, who are you??"
                     "Wait, I'm a chicken..."
                     "I can't talk!")))

  (minecraft-game
    #:entity-list (list (my-entity) (another-entity))))

;====================================================

(define-example-code 
  ;#:with-test (test game-test)
  survival-minecraft alt/background-4  
  (define (my-biome)
    (basic-biome
      #:image LAVA-BG
      #:rows 2
      #:columns 2
      #:start-tile 3
      #:hd? #t))

  (minecraft-game #:biome (my-biome)))

;====================================================






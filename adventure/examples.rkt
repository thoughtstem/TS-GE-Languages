#lang racket

(require ts-kata-util adventure)

(define-example-code adventure hello-world-1
  (adventure-game))


; -----------------

(define-example-code adventure avatar-1
  (adventure-game
   #:avatar (custom-avatar))
  )
                                       
(define-example-code adventure avatar-2
  (define (my-avatar)
    (custom-avatar #:sprite wizard-sprite))

  (adventure-game
   #:avatar (my-avatar))
  )

(define-example-code adventure avatar-3
  (define (my-avatar)
    (custom-avatar #:sprite pirate-sprite
                   #:speed  20))

  (adventure-game
   #:avatar (my-avatar))
  )

(define-example-code adventure avatar-4
  (define (my-avatar)
    (custom-avatar #:sprite monk-sprite
                   #:speed  20
                   #:key-mode 'wasd))

  (adventure-game
   #:avatar (my-avatar))
  )

; -----------------

(define-example-code adventure coin-1
  (adventure-game
   #:avatar     (custom-avatar)
   #:coin-list  (list (custom-coin)))
  )

(define-example-code adventure coin-2 
  (define (my-coin)
    (custom-coin #:value 500))
 
  (adventure-game
   #:avatar     (custom-avatar)
   #:coin-list  (list (my-coin)))
  )

(define-example-code adventure coin-3
  (define (my-coin)
    (custom-coin #:sprite          silver-coin-sprite
                 #:name            "Silver Coin"
                 #:value           500
                 #:amount-in-world 20))

  (adventure-game
   #:avatar     (custom-avatar)
   #:coin-list  (list (my-coin)))
  )

(define-example-code adventure coin-4
  
  (define (my-coin)
    (custom-coin #:sprite silver-coin-sprite
                 #:name   "Silver Coin"))

  (define (my-special-coin)
    (custom-coin #:sprite          gold-coin-sprite
                 #:name            "Gold Coin"
                 #:value           1000
                 #:amount-in-world 1
                 #:respawn?        #f))

  (adventure-game
   #:avatar     (custom-avatar)
   #:coin-list  (list (my-coin)
                      (my-special-coin)))
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
   #:avatar     (custom-avatar)
   #:enemy-list (list (custom-enemy)))
  )

(define-example-code adventure enemy-2
  (adventure-game
   #:avatar     (custom-avatar)
   #:enemy-list (list (curry custom-enemy #:amount-in-world 10)))
  )

(define-example-code adventure enemy-3 
  (define (my-enemy)
    (custom-enemy #:ai              'medium
                  #:sprite          bat-sprite
                  #:amount-in-world 5))
 
  (adventure-game
   #:avatar     (custom-avatar)
   #:enemy-list (list (my-enemy))))

(define-example-code adventure enemy-4
  (define (easy-enemy)
    (custom-enemy #:ai           'easy
                  #:sprite       slime-sprite
                  #:amount-in-world 5))
  
  (define (medium-enemy)
    (custom-enemy #:ai              'medium
                  #:sprite          bat-sprite
                  #:amount-in-world 5
                  #:night-only? #t))
 
  (adventure-game
   #:avatar     (custom-avatar)
   #:enemy-list (list (easy-enemy)
                      (medium-enemy))))

(define-example-code adventure enemy-5
  (define (hard-enemy)
    (custom-enemy #:ai              'hard
                  #:sprite          snake-sprite
                  #:amount-in-world 5
                  #:weapon          (acid-spitter #:damage 50)))
 
  (adventure-game
   #:avatar       (custom-avatar)
   #:enemy-list   (list (hard-enemy)))
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

; Make a game with a forest background
; filled with high definition round trees and pine trees
(define-example-code adventure level-design-2

  (adventure-game
   #:bg             (custom-bg #:image FOREST-BG)
   #:other-entities (make-world-objects round-tree
                                        pine-tree
                                        #:hd? #t))
  )

; Make a game with a pink background
; filled with random color and high definition candy-cane-trees and snow-pine-trees
(define-example-code adventure level-design-3

  (adventure-game
   #:bg             (custom-bg #:image PINK-BG)
   #:other-entities (make-world-objects candy-cane-tree
                                        snow-pine-tree
                                        #:hd? #t
                                        #:random-color? #t))
  
  )

; Make a game with an HD desert background
; filled with random HD brown rocks
(define-example-code adventure level-design-4

  (adventure-game
   #:bg             (custom-bg #:image DESERT-BG
                               #:hd? #t)
   #:other-entities (make-world-objects random-brown-rock
                                        random-brown-rock
                                        #:hd? #t))
  
  )

; Make a game with an HD lava background
; filled with random HD gray rocks
(define-example-code adventure level-design-5

  (adventure-game
   #:bg             (custom-bg #:image LAVA-BG
                               #:hd? #t)
   #:other-entities (make-world-objects random-gray-rock
                                        random-gray-rock
                                        #:hd? #t))
  
  )

; Make a game with any background and
; 3 world objects with customized position, tile, size, and/or hue
(define-example-code adventure level-design-6
  
  (adventure-game
   #:other-entities (barrels (posn 100 200) #:tile 0)
                    (large-gray-rock  (posn 100 200) #:tile 1 #:size 2)
                    (brick-house (posn 200 200) #:tile 2 #:hue (random 360)))
  
  )

; ==============================


;Tests all examples as games for 10 ticks
(test-all-examples-as-games 'adventure)


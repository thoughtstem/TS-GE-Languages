#lang racket

(require ts-kata-util)

(define-example-code
  ;#:with-test (test game-test)
  survival hello-world-1
  (survival-game))

; -----------------

(define-example-code
  ;#:with-test (test game-test)
  survival avatar-1
  (survival-game
   #:avatar (basic-avatar))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival avatar-2
  (survival-game
   #:avatar (basic-avatar
             #:sprite wizard-sprite))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival avatar-3
  (define (my-avatar)
    (basic-avatar #:sprite pirate-sprite
                  #:speed 20))

  (survival-game
   #:avatar (my-avatar))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival avatar-4
  (define (my-avatar)
    (basic-avatar #:sprite monk-sprite
                  #:speed 20
                  #:key-mode 'wasd))

  (survival-game
   #:avatar (my-avatar))
  )


(define-example-code
  ;#:with-test (test game-test)
  survival avatar-5
  (define (my-avatar)
    (basic-avatar #:sprite wizard-sprite
                  #:speed 20
                  #:key-mode 'wasd
                  #:health 200
                  #:max-health 200))

  (survival-game
   #:avatar (my-avatar))
  )
; -----------------

(define-example-code
  ;#:with-test (test game-test)
  survival coin-1
  (survival-game
   #:coin-list  (list (basic-coin)))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival coin-2 
  (define (my-coin)
    (basic-coin #:value 500))

  (survival-game
   #:coin-list  (list (my-coin)))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival coin-3
  (define (my-coin)
    (basic-coin #:sprite          silvercoin-sprite
                #:name            "Silver Coin"
                #:value           100
                #:amount-in-world 20))

  (survival-game
   #:coin-list  (list (my-coin)))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival coin-4  
  (define (my-coin)
    (basic-coin #:sprite silvercoin-sprite
                #:name   "Silver Coin"))

  (define (my-special-coin)
    (basic-coin #:sprite          goldcoin-sprite
                #:name            "Gold Coin"
                #:value           1000
                #:amount-in-world 1
                #:respawn?        #f))

  (survival-game
   #:coin-list  (list (my-coin)
                      (my-special-coin)))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival coin-5
  (define (silver-coin)
    (basic-coin #:sprite silvercoin-sprite
                #:name   "Silver Coin"
                #:value  500
                #:amount-in-world 5))

  (define (gold-coin)
    (basic-coin #:sprite          goldcoin-sprite
                #:name            "Gold Coin"
                #:value           1000
                #:amount-in-world 1
                #:respawn?        #f))

  (survival-game
   #:coin-list  (list (basic-coin)
                      (silver-coin)
                      (gold-coin)))
  )

; ------------

(define-example-code
  ;#:with-test (test game-test)
  survival crafter-1
  (survival-game
   #:crafter-list (list
                   (basic-crafter
                    #:sprite cauldron-sprite
                    #:position (posn 200 200)
                    #:tile 2)))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival crafter-2
  (survival-game
   #:food-list (list
                (carrot
                 #:name "Carrot"
                 #:amount-in-world 10))
   #:crafter-list (list
                   (basic-crafter
                    #:recipe-list (list
                                   carrot-stew-recipe))))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival crafter-3
  (define (fish-stew)
    (basic-product #:name "Fish Stew"
                   #:sprite fishstew-sprite
                   #:heals-by 50))

  (define fish-stew-recipe
    (recipe #:product (fish-stew)
            #:ingredients (list "Fish")))

  (survival-game
   #:food-list (list (fish))
   #:crafter-list (list
                   (basic-crafter
                    #:recipe-list (list
                                   fish-stew-recipe))))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival crafter-4  
  (define (fish-stew)
    (basic-product #:name "Fish Stew"
                   #:sprite fishstew-sprite
                   #:heals-by 50))

  (define fish-stew-recipe
    (recipe #:product (fish-stew)
            #:ingredients (list "Fish")))

  (define (my-cauldron)
    (basic-crafter
     #:recipe-list (list
                    carrot-stew-recipe
                    fish-stew-recipe)))

  (survival-game
   #:food-list (list
                (carrot #:amount-in-world 10)
                (fish #:amount-in-world 10))
   #:crafter-list (list
                   (my-cauldron)))
  )

; sword, damage, has-gold? options (spear) fire-magic, etc
(define-example-code
  ;#:with-test (test game-test)
  survival weapon-crafter-1
  (define my-sword-recipe
    (recipe #:product (sword)
            #:build-time 20))

  (survival-game
   #:crafter-list (list
                   (basic-crafter
                    #:sprite woodtable-sprite
                    #:recipe-list (list
                                   my-sword-recipe))))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival weapon-crafter-2
  (define my-sword-recipe
    (recipe #:product (sword #:damage 100)
            #:build-time 100))

  (survival-game
   #:crafter-list (list (basic-crafter
                         #:sprite woodtable-sprite
                         #:recipe-list (list my-sword-recipe))))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival weapon-crafter-3
  (define my-fire-magic-recipe
    (recipe #:product (fire-magic
                       #:name "Fast Flame"
                       #:speed 7)
            #:cost 100))

  (survival-game
   #:coin-list (list
                (basic-coin))
   #:crafter-list (list
                   (basic-crafter
                    #:sprite woodtable-sprite
                    #:recipe-list (list
                                   my-fire-magic-recipe))))
  )

; -----------------

(define-example-code
  ;#:with-test (test game-test)
  survival sky-1 
  (survival-game
   #:sky    (basic-sky #:length-of-day 5000))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival sky-2
  (survival-game
   #:sky (basic-sky #:night-sky-color  'darkmagenta))
  )


(define-example-code
  ;#:with-test (test game-test)
  survival sky-3 
  (survival-game
   #:sky    (basic-sky #:length-of-day 500
                       #:max-darkness  255))
  )


(define-example-code
  ;#:with-test (test game-test)
  survival sky-4 

  (survival-game
   #:enemy-list   (list (basic-enemy #:amount-in-world 20
                                     #:night-only? #t))
   #:sky          (basic-sky #:length-of-day    2400
                             #:start-of-daytime 200
                             #:end-of-daytime   2200))
  )

; -----------------

(define-example-code
  ;#:with-test (test game-test)
  survival enemy-1
  (survival-game
   #:enemy-list (list
                 (basic-enemy)))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival enemy-2
  (survival-game
   #:enemy-list (list
                 (basic-enemy
                  #:amount-in-world 10)))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival enemy-3 
  (define (my-enemy)
    (basic-enemy #:ai 'medium
                 #:sprite bat-sprite
                 #:amount-in-world 5))

  (survival-game
   #:enemy-list (list
                 (my-enemy))))

(define-example-code
  ;#:with-test (test game-test)
  survival enemy-4
  (define (easy-enemy)
    (basic-enemy #:ai 'easy
                 #:sprite slime-sprite
                 #:amount-in-world 5))

  (define (medium-enemy)
    (basic-enemy #:ai 'medium
                 #:sprite bat-sprite
                 #:amount-in-world 5
                 #:night-only? #t))

  (survival-game
   #:enemy-list (list
                 (easy-enemy)
                 (medium-enemy))))

(define-example-code
  ;#:with-test (test game-test)
  survival enemy-5
  (define (hard-enemy)
    (basic-enemy #:ai 'hard
                 #:sprite snake-sprite
                 #:amount-in-world 5
                 #:weapon (acid-spitter
                           #:damage 50)))

  (survival-game
   #:enemy-list (list
                 (hard-enemy)))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival enemy-6
  (define (easy-enemy)
    (basic-enemy #:ai 'easy
                 #:sprite slime-sprite
                 #:amount-in-world 5))

  (define (medium-enemy)
    (basic-enemy #:ai 'medium
                 #:sprite snake-sprite
                 #:amount-in-world 3
                 ))

  (define (hard-enemy)
    (basic-enemy #:ai 'hard
                 #:sprite bat-sprite
                 #:amount-in-world 1
                 #:night-only? #t
                 #:weapon (acid-spitter
                           #:damage 50)))

  (survival-game
   #:enemy-list (list (easy-enemy)
                      (medium-enemy)
                      (hard-enemy)))
  )

; -----------------

(define-example-code
  ;#:with-test (test game-test)
  survival food-1
  (survival-game
   #:food-list (list
                (basic-food
                 #:amount-in-world 10)))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival food-2
  (define (my-food)
    (basic-food #:amount-in-world 2
                #:heals-by 20))

  (survival-game
   #:food-list (list
                (my-food)))
  )


(define-example-code
  ;#:with-test (test game-test)
  survival food-3
  (define (my-food)
    (basic-food #:sprite apples-sprite
                #:name "Apples"
                #:amount-in-world 2
                #:heals-by 20))

  (survival-game
   #:food-list (list
                (my-food)))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival food-4

  (define (my-food)
    (basic-food #:sprite apples-sprite
                #:name "Apples"
                #:amount-in-world 15
                #:heals-by 5))

  (define (special-food)
    (basic-food #:sprite cherry-sprite
                #:name "Cherry"
                #:amount-in-world 1
                #:heals-by 50
                #:respawn? #f))

  (survival-game
   #:food-list (list (my-food)
                     (special-food))))

(define-example-code
  ;#:with-test (test game-test)
  survival food-5
  (define (my-food)
    (basic-food #:sprite cherry-sprite
                #:name "Cherries"
                #:amount-in-world 20
                #:heals-by 50))

  (survival-game
   #:food-list (list
                (my-food))
   #:starvation-rate 100)
  )

(define-example-code
  ;#:with-test (test game-test)
  survival food-6
  (define (basic-cherry)
    (basic-food #:sprite          cherry-sprite
                #:name            "Cherries"
                #:amount-in-world 15))

  (define (basic-smores)
    (basic-food #:sprite          smores-sprite
                #:name            "Smores"
                #:heals-by        -10))

  (define (special-carrot)
    (basic-food #:sprite   carrot-sprite
                #:name     "Carrots"
                #:tile     4
                #:amount-in-world 1
                #:heals-by 50
                #:respawn? #f))

  (survival-game
   #:food-list       (list (basic-cherry)
                           (basic-smores)
                           (special-carrot)))
  )
; -----------------

(define-example-code
  ;#:with-test (test game-test)
  survival npc-1
  (survival-game
   #:npc-list (list (basic-npc)))
  )


(define-example-code
  ;#:with-test (test game-test)
  survival npc-2
  (define (my-npc)
    (basic-npc
     #:sprite witch-sprite
     #:name   "Witch"))

  (survival-game
   #:npc-list (list (my-npc)))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival npc-3
  (define (my-npc)
    (basic-npc
     #:dialog (list "Woah, who are you??"
                    "Nevermind -- I'm too busy."
                    "Move along, now!")))
  (survival-game
   #:npc-list (list (my-npc)))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival npc-4
  (define (my-npc)
    (basic-npc
     #:sprite witch-sprite
     #:name   "Witch"
     #:tile   3
     #:mode   'follow))

  (survival-game
   #:npc-list (list (my-npc)))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival npc-5
  (define (my-npc)
    (basic-npc
     #:name   "Francis"
     #:tile   4
     #:dialog (list "Greetings!"
                    "You better find some food soon...")))

  (define (another-npc)
    (basic-npc
     #:sprite witch-sprite
     #:mode   'pace
     #:dialog (list "Now where did I put it..."
                    "Have you seen an eye of newt?"
                    "Oh, I think I see it!")))

  (survival-game
   #:npc-list (list (my-npc) (another-npc)))
  )

; -----------------

(define-example-code
  ;#:with-test (test game-test)
  survival background-1
  (survival-game
   #:bg (basic-bg))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival background-2
  (survival-game
   #:bg (basic-bg
         #:image DESERT-BG))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival background-3
  (define (my-bg)
    (basic-bg
     #:image LAVA-BG
     #:rows 2
     #:columns 2))

  (survival-game
   #:bg (my-bg))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival background-4
  (define (my-bg)
    (basic-bg #:image LAVA-BG
              #:rows 2
              #:columns 2
              #:start-tile 3
              #:hd? #t))

  (survival-game #:bg (my-bg))
  )


; -----------------

; ==== LEVEL DESIGN KATAS ====
(define-example-code
  ;#:with-test (test game-test)
  survival level-design-1

  (survival-game
   #:bg (basic-bg
         #:image FOREST-BG)
   #:enable-world-objects? #t)

  )

(define-example-code
  ;#:with-test (test game-test)
  survival level-design-2

  (survival-game
   #:bg (basic-bg
         #:image FOREST-BG)
   #:other-entities
   (make-world-objects
    round-tree
    pine-tree
    #:hd? #t))
  )

(define-example-code
  ;#:with-test (test game-test)
  survival level-design-3

  (survival-game
   #:bg (basic-bg
         #:image PINK-BG)
   #:other-entities (make-world-objects
                     candy-cane-tree
                     snow-pine-tree
                     #:hd? #t
                     #:random-color? #t))

  )

(define-example-code
  ;#:with-test (test game-test)
  survival level-design-4

  (survival-game
   #:other-entities
   (pine-tree (posn 100 200)
              #:tile 0)
   (wood-house (posn 100 200)
               #:tile 1
               #:size 0.5)
   (brick-house (posn 100 200)
                #:tile 2
                #:hue (random 360)))

  )

; ==============================

(define-example-code
  ;#:with-test (test game-test)
  survival game-jam-1 
  (survival-game
   #:avatar       (basic-avatar)
   #:coin-list    (list (basic-coin))
   #:food-list    (list (basic-food #:amount-in-world 10))
   #:enemy-list   (list (basic-enemy))
   #:crafter-list (list (basic-crafter))))

(define-example-code
  ;#:with-test (test game-test)
  survival game-jam-2
  (define (my-avatar)
    (basic-avatar #:sprite wizard-sprite))

  #;
  (define (silver-coin)
    (basic-coin #:sprite silvercoin-sprite
                #:name "silver coin"
                #:amount-in-world 6
                #:value 20))

  (define (gold-coin)
    (basic-coin #:sprite goldcoin-sprite
                #:name "gold coin"
                #:amount-in-world 4
                #:value 40))


  (define (toasted-marshmallow)
    (basic-food #:sprite          toastedmarshmallow-sprite
                #:name            "toasted marshmallow"
                #:heals-by        5
                #:amount-in-world 5))

  (define (cherry)
    (basic-food #:sprite          cherry-sprite
                #:name            "cherry"
                #:heals-by        50
                #:respawn?        #f))

  (define (carrot)
    (basic-food #:sprite          carrot-sprite
                #:name            "carrot"
                #:amount-in-world 5))

  (define (bowl)
    (basic-food #:sprite          bowl-sprite
                #:name            "bowl"
                #:heals-by        0
                #:amount-in-world 2))

  (define (my-enemy-1)
    (basic-enemy #:ai              'easy
                 #:sprite          snake-sprite
                 #:amount-in-world 5))

  (define (my-enemy-2)
    (basic-enemy #:ai              'medium
                 #:sprite          bat-sprite
                 #:amount-in-world 2
                 #:night-only?     #t))

  (define (smores)
    (basic-food #:sprite smores-sprite
                #:name "smores"
                #:heals-by 40))

  (define (steak)
    (basic-food #:sprite  steak-sprite
                #:name    "steak"
                #:heals-by 50))

  (define (carrot-stew)
    (basic-food #:sprite   carrotstew-sprite
                #:name     "carrot-stew"
                #:heals-by 60))


  (define smores-recipe
    (recipe #:product     (smores)
            #:build-time  10
            #:ingredients (list "toasted marshmallow")))

  (define steak-recipe
    (recipe #:product     (steak)
            #:build-time  5
            #:ingredients (list "cherry" "toasted marshmallow")))

  (define carrot-stew-recipe
    (recipe #:product     (carrot-stew)
            #:build-time  15
            #:ingredients (list "carrot" "bowl")))


  (define (campfire)
    (basic-crafter #:sprite      campfire-sprite
                   #:position    (posn 200 200)
                   #:tile        2
                   #:recipe-list (list smores-recipe
                                       steak-recipe)))
  (define (cauldron)
    (basic-crafter #:sprite      cauldron-sprite
                   #:position    (posn 200 200)
                   #:tile        3
                   #:recipe-list (list carrot-stew-recipe)))



  (survival-game
   #:avatar       (my-avatar)
   #:coin-list    (list 
                   #;
                   (silver-coin)
                   (gold-coin))
   #:food-list    (list (toasted-marshmallow)
                        (cherry)
                        (carrot)
                        (bowl))
   #:enemy-list   (list (my-enemy-1)
                        (my-enemy-2))
   #:crafter-list (list (cauldron)
                        (campfire))))




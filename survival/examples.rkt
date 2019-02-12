#lang racket

(require ts-kata-util survival)
 
(define-example-code survival avatar-1
 (survival-game
   #:avatar (custom-avatar)))

(define-example-code survival avatar-2 

  (define (my-avatar)
    (custom-avatar #:sprite (star 30 'solid 'yellow)))
  
 (survival-game
   #:avatar (my-avatar)))


(define-example-code survival avatar-3

  (define (my-avatar)
    (custom-avatar #:sprite (random-character-sprite)))
  
 (survival-game
   #:avatar (my-avatar)))

                                       
(define-example-code survival avatar-4
  (define (my-avatar)
    (custom-avatar #:sprite STUDENT-IMAGE-HERE))

   (survival-game
     #:avatar (my-avatar)))

(define-example-code survival avatar-5
  (define (my-avatar)
    (custom-avatar #:sprite (sheet->sprite STUDENT-IMAGE-HERE
                                           #:columns 4)))

   (survival-game
     #:avatar (my-avatar)))

 
(define-example-code survival coin-1

  (survival-game
   #:avatar     (custom-avatar)
   #:coin-list  (list (custom-coin))))


 
(define-example-code survival coin-2
  
  (define (my-coin)
    (custom-coin #:value 500))
 
  (survival-game
   #:avatar     (custom-avatar)
   #:coin-list  (list (my-coin))))



(define-example-code survival coin-3
  (define (my-coin)
    (custom-coin #:sprite          silver-coin-sprite
                 #:name            "Silver Coin"
                 #:value           500
                 #:amount-in-world 20))

  (survival-game
   #:avatar     (custom-avatar)
   #:coin-list  (list (my-coin))))


(define-example-code survival coin-4
  
  (define (my-coin)
    (custom-coin #:sprite silver-coin-sprite
                 #:name   "Silver Coin"))

  (define (my-special-coin)
    (custom-coin #:sprite          gold-coin-sprite
                 #:name            "Gold Coin"
                 #:value           1000
                 #:amount-in-world 1
                 #:respawn?        #f))

  (survival-game
   #:avatar     (custom-avatar)
   #:coin-list  (list (my-coin)
                      (my-special-coin))))


(define-example-code survival crafter-1

  (survival-game
   #:avatar       (custom-avatar)
   #:crafter-list (list (custom-crafter))))

(define-example-code survival crafter-2
  (survival-game
   #:avatar       (custom-avatar)
   #:food-list    (list (carrot #:amount-in-world 10))
   #:crafter-list (list (custom-crafter
                         #:recipe-list (list carrot-stew-recipe)))))
 
(define-example-code survival crafter-3

  (define (fish-stew)
    (custom-food #:name "Fish Stew"
                 #:sprite fish-stew-sprite
                 #:respawn? #f
                 #:heals-by 50))

  (define fish-stew-recipe
    (recipe #:product (fish-stew)
            #:build-time 40
            #:ingredients (list "Fish")))

  (survival-game
   #:avatar       (custom-avatar)
   #:food-list    (list (fish #:amount-in-world 10))
   #:crafter-list (list (custom-crafter #:sprite cauldron-sprite
                                        #:recipe-list (list fish-stew-recipe)))))



(define-example-code survival crafter-4
  
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
  
  (survival-game
   #:avatar       (custom-avatar)
   #:food-list    (list (carrot #:amount-in-world 10)
                        (fish   #:amount-in-world 10))
   #:crafter-list (list (my-cauldron))))



; Make a survival game with an avatar and a slow changing sky
(define-example-code survival sky-1 

  (survival-game
   #:avatar (custom-avatar)
   #:sky    (custom-sky #:length-of-day 5000))
   )

; Make a survival game with an avatar and a fast changing sky with max-darkness
(define-example-code survival sky-2 

  (survival-game
   #:avatar (custom-avatar)
   #:sky    (custom-sky #:length-of-day 500
                        #:max-darkness  255)))

; Make a survival game with an avatar and a darkmagenta night-sky with 150 darkness
(define-example-code survival sky-3 

  (survival-game
   #:avatar (custom-avatar)
   #:sky (custom-sky #:night-sky-color  'darkmagenta
                     #:max-darkness     150)))

; Make a survival game with an avatar and a very short night-time and an enemy that only comes out at night.
(define-example-code survival sky-4 

  (survival-game
   #:avatar       (custom-avatar)
   #:enemy-list   (list (custom-enemy #:amount-in-world 20
                                      #:night-only? #t))
   #:sky          (custom-sky #:length-of-day    2400
                              #:start-of-daytime 200
                              #:end-of-daytime   2200)))

; Make a a survival game with the fastest starvation rate
(define-example-code survival starvation-rate
  (survival-game
   #:avatar          (custom-avatar)
   #:starvation-rate 100))
 
(define-example-code survival enemy-1

  (survival-game
   #:avatar     (custom-avatar)
   #:enemy-list (list (custom-enemy))))

(define-example-code survival enemy-2

  (survival-game
   #:avatar     (custom-avatar)
   #:enemy-list (list (curry custom-enemy #:amount-in-world 10))))


(define-example-code survival enemy-3
  
  (define (my-enemy)
    (custom-enemy #:ai              'medium
                  #:sprite          bat-sprite
                  #:amount-in-world 5))
 
  (survival-game
   #:avatar     (custom-avatar)
   #:enemy-list (list (my-enemy))))

(define-example-code survival enemy-4

  (define (easy-enemy)
    (custom-enemy #:ai           'easy
                  #:sprite       slime-sprite
                  #:amount-in-world 5))
  
  (define (medium-enemy)
    (custom-enemy #:ai              'medium
                  #:sprite          bat-sprite
                  #:amount-in-world 5
                  #:night-only? #t))
 
  (survival-game
   #:avatar     (custom-avatar)
   #:enemy-list (list (easy-enemy)
                      (medium-enemy))))

(define-example-code survival enemy-5
 
  (define (hard-enemy)
    (custom-enemy #:ai              'hard
                  #:sprite          snake-sprite
                  #:amount-in-world 5
                  #:weapon          (acid-spitter #:damage 50)))
 
  (survival-game
   #:avatar       (custom-avatar)
   #:enemy-list   (list (hard-enemy))))




(define-example-code survival food-1

  (survival-game
   #:avatar     (custom-avatar)
   #:food-list  (list (custom-food #:amount-in-world 10))))


(define-example-code survival food-2
  (define (my-food)
    (custom-food #:amount-in-world 2
                 #:heals-by        20))
 
  (survival-game
   #:avatar     (custom-avatar)
   #:food-list  (list (my-food))))



(define-example-code survival food-3

  (define (my-food)
    (custom-food #:sprite          apples-sprite
                 #:name            "Apples"
                 #:amount-in-world 2
                 #:heals-by        20))

  (survival-game
   #:avatar     (custom-avatar)
   #:food-list  (list (my-food))))

 
(define-example-code survival food-4

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

  (survival-game
   #:avatar     (custom-avatar)
   #:food-list  (list (my-food)
                      (special-food))))



(define-example-code survival npc-1

  (survival-game
   #:avatar   (custom-avatar)
   #:npc-list (list (custom-npc))))


(define-example-code survival npc-2

  (define (my-npc)
    (custom-npc
     #:sprite (witch-sprite)
     #:name   "Witch"))

  (survival-game
   #:avatar   (custom-avatar)
   #:npc-list (list (my-npc))))


(define-example-code survival npc-3
  (define (my-npc)
    (custom-npc
     #:sprite (witch-sprite)
     #:name   "Witch"
     #:tile   3
     #:mode   'follow))

  (survival-game
   #:avatar   (custom-avatar)
   #:npc-list (list (my-npc))))


(define-example-code survival npc-4
  (define (my-npc)
    (custom-npc
     #:dialog (list "Woah, who are you??"
                    "Nevermind -- I'm too busy."
                    "Move along, now!")))
  (survival-game
   #:avatar   (custom-avatar)
   #:npc-list (list (my-npc))))


(define-example-code survival npc-5
  (define (my-npc)
    (custom-npc
     #:name   "Francis"
     #:tile   4
     #:dialog (list "Greetings!"
                    "You better find some food soon...")))

  (define (another-npc)
    (custom-npc
     #:sprite (witch-sprite)
     #:mode   'pace
     #:dialog (list "Now where did I put it..."
                    "Have you seen an eye of newt?"
                    "Oh, I think I see it!")))

  (survival-game
   #:avatar   (custom-avatar)
   #:npc-list (list (my-npc) (another-npc))))



(define-example-code survival bg-1

  (survival-game
   #:avatar (custom-avatar)
   #:bg (custom-bg)))

(define-example-code survival bg-2
  (survival-game
   #:avatar (custom-avatar)
   #:bg (custom-bg #:image DESERT-BG)))

(define-example-code survival bg-3
  (define (my-bg)
    (custom-bg
     #:image LAVA-BG
     #:start-tile 4))

  (survival-game
   #:avatar (custom-avatar)
   #:bg (my-bg)))
  


 
(define-example-code survival game-jam-1
  
(survival-game
  #:avatar       (custom-avatar)
  #:coin-list    (list (custom-coin))
  #:food-list    (list (custom-food #:amount-in-world 10))
  #:enemy-list   (list (custom-enemy))
  #:crafter-list (list (custom-crafter))))

(define-example-code survival racket-1

  (require 2htdp/image)
  (circle 80 'solid 'red))



(define-example-code survival game-jam-2
  (define (my-avatar)
    (custom-avatar #:sprite (sheet->sprite STUDENT-IMAGE-HERE
                                           #:columns 4)))

  (define (red-coin)
    (custom-coin #:sprite (circle 5 'solid 'red)
                 #:name "red coin"
                 #:amount-in-world 6
                 #:value 20))
   
   
  (define (blue-coin)
    (custom-coin #:sprite (circle 5 'solid 'blue)
                 #:name "blue coin"
                 #:amount-in-world 4
                 #:value 40))
   
   
  (define (green-coin)
    (custom-coin #:sprite (circle 5 'solid 'green)
                 #:name "green coin"
                 #:amount-in-world 2
                 #:respawn? #f
                 #:value 60))

  (define (pineapple)
    (custom-food #:sprite          (star 5 'solid 'yellow)
                 #:name            "pineapple"
                 #:heals-by        5
                 #:amount-in-world 10))
   
  (define (mango)
    (custom-food #:sprite          (star 5 'solid 'orange)
                 #:name            "mango"
                 #:heals-by        50
                 #:amount-in-world 1
                 #:respawn?        #f))

  (define (my-enemy-1)
    (custom-enemy #:ai              'easy
                  #:sprite          snake-sprite
                  #:amount-in-world 5))
   
  (define (my-enemy-2)
    (custom-enemy #:ai              'medium
                  #:sprite          bat-sprite
                  #:amount-in-world 2
                  #:weapon          (custom-weapon #:name "Acidtron"
                                                   #:dart (custom-dart #:damage 50
                                                                       #:speed  20))))

  (define (kiwi)
    (custom-food #:sprite (star 5 'solid 'brown)
                 #:name "kiwi"
                 #:heals-by 50))
   
   
  (define (frozen-pineapple)
    (custom-food #:sprite (star 10 'solid 'yellow)
                 #:name "frozen pineapple"
                 #:heals-by 15))
   
   
  (define kiwi-recipe
    (recipe #:product     (kiwi)
            #:build-time  5
            #:ingredients (list "pineapple" "mango")))
   
   
  (define mango-recipe
    (recipe #:product     (mango)
            #:build-time  10
            #:ingredients (list "pineapple")))
   
   
  (define frozen-pineapple-recipe
    (recipe #:product     (frozen-pineapple)
            #:build-time  15
            #:ingredients (list "pineapple")))
   
   
  (define (oven-crafter)
    (custom-crafter #:menu (crafting-menu-set! #:recipes kiwi-recipe
                                               mango-recipe)
                    #:tile 1))
   
  (define (freezer-crafter)
    (custom-crafter #:menu (crafting-menu-set! #:recipes frozen-pineapple-recipe)
                    #:tile 2))

  (survival-game
   #:avatar       (my-avatar)
   #:coin-list    (list (red-coin)
                        (blue-coin)
                        (green-coin))
   #:food-list    (list (pineapple)
                        (mango)
                        (kiwi)
                        (frozen-pineapple))
   #:enemy-list   (list (my-enemy-1)
                        (my-enemy-2))
   #:crafter-list (list (oven-crafter)
                        (freezer-crafter))))


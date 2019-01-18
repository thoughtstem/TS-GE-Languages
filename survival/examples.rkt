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
    (custom-avatar #:sprite bat-sprite))
  
 (survival-game
   #:avatar (my-avatar)))

                                         

 
(define-example-code survival avatar-4
 (define (my-avatar)
   (custom-avatar #:sprite (circle 40 "solid" "red")))

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
    (custom-coin #:sprite          copper-coin-sprite
                 #:name            "copper coin"
                 #:value           500
                 #:amount-in-world 20))

  (survival-game
   #:avatar     (custom-avatar)
   #:coin-list  (list (my-coin))))



(define-example-code survival coin-4
  
  (define (my-coin)
    (custom-coin #:sprite copper-coin-sprite
                 #:name   "copper coin"))

  (define (special-coin)
    (custom-coin #:sprite          bat-sprite
                 #:name            "bat coin"
                 #:value           1000
                 #:amount-in-world 1
                 #:respawn?        #f))

  (survival-game
   #:avatar     (custom-avatar)
   #:coin-list  (list (my-coin)
                      (special-coin))))



(define-example-code survival crafter-1

  (survival-game
   #:avatar       (custom-avatar)
   #:crafter-list (list (custom-crafter))))




(define-example-code survival crafter-2
  (define (carrot-cake)
    (custom-food #:sprite          (rectangle 40 20 "solid" "brown")
                 #:name            "Carrot Cake"
                 #:heals-by        25
                 #:amount-in-world 1))

  (survival-game
   #:avatar       (custom-avatar)
   #:food-list    (list (custom-food #:amount-in-world 10)
                        (carrot-cake))
   #:crafter-list (list (custom-crafter))))


 
(define-example-code survival crafter-3

  (define (carrot-cake)
    (custom-food #:sprite   (rectangle 40 20 "solid" "brown")
                 #:name     "Carrot Cake"
                 #:heals-by 25))

  (define carrot-cake-recipe
    (recipe #:product     (carrot-cake)
            #:build-time  5
            #:ingredients (list "Carrot")))

  (define (my-oven)
    (custom-crafter #:menu (crafting-menu-set! #:recipes carrot-cake-recipe))) 

  (survival-game
   #:avatar       (custom-avatar)
   #:food-list    (list (custom-food #:amount-in-world 10)
                        (carrot-cake))
   #:crafter-list (list (my-oven))))



(define-example-code survival crafter-4
  (define (carrot-cake)
    (custom-food #:sprite   (rectangle 40 20 "solid" "brown")
                 #:name     "Carrot Cake"
                 #:heals-by 25))

  (define carrot-cake-recipe
    (recipe #:product     (carrot-cake)
            #:build-time  5
            #:ingredients (list "Carrot")
            ))

  (define (carrot-cupcake)
    (custom-food #:sprite   (square 10 "solid" "brown")
                 #:name     "Carrot Cupcake"
                 #:heals-by 15))

  (define carrot-cupcake-recipe
    (recipe #:product     (carrot-cupcake)
            #:build-time  10
            #:ingredients (list "Carrot Cake")
            ))

  (define (my-oven)
    (custom-crafter #:menu (crafting-menu-set! #:recipes carrot-cake-recipe
                                               carrot-cupcake-recipe))) 

  (survival-game
   #:avatar       (custom-avatar)
   #:food-list    (list (custom-food #:amount-in-world 10)
                        (carrot-cake))
   #:crafter-list (list (my-oven))))


(define-example-code survival day-night-cycle  
  (define (my-stew)
    (custom-food #:name "Carrot Stew"
                 #:sprite carrot-stew-sprite
                 #:heals-by 40
                 #:respawn? #f))
  
  (survival-game
   #:bg     (custom-background #:bg-img FOREST-BG)
   #:avatar (custom-avatar #:sprite (random-character-sprite)
                           #:key-mode 'wasd
                           #:mouse-aim? #t)
   #:starvation-rate 20
   
   #:sky (custom-sky #:night-sky-color  'darkmagenta
                     #:length-of-day    4000
                     #:start-of-daytime 1000
                     #:end-of-daytime   3000 
                     #:max-darkness     150)
   
   #:coin-list  (list (custom-coin))
   #:npc-list   (list (custom-npc))
   #:enemy-list (list (custom-enemy #:sprite slime-sprite
                                    #:amount-in-world 10
                                    #:ai 'easy
                                    #:weapon (custom-weapon #:dart (acid #:damage 0))
                                    #:night-only? #t))
   #:food-list  (list (custom-food #:name "Carrot"
                                   #:sprite carrot-sprite
                                   #:amount-in-world 10)
                      (my-stew) )
   #:crafter-list (list (custom-crafter
                         #:menu (crafting-menu-set!
                                 #:recipes (recipe #:product (my-stew)
                                                   #:build-time 20
                                                   #:ingredients (list "Carrot")))))
   ))




 
(define-example-code survival enemy-1

  (survival-game
   #:avatar     (custom-avatar)
   #:enemy-list (list (custom-enemy))))




(define-example-code survival enemy-2
  
  (define (my-enemy)
    (custom-enemy #:ai              'medium
                  #:sprite          bat-sprite
                  #:amount-in-world 5))
 
  (survival-game
   #:avatar     (custom-avatar)
   #:enemy-list (list (my-enemy))))



(define-example-code survival enemy-3

  (define (my-weapon)
    (custom-weapon #:name "Acidtron"
                   #:dart (custom-dart #:damage 50
                                       #:speed  20)))
 
  (define (my-enemy)
    (custom-enemy #:ai              'medium
                  #:sprite          bat-sprite
                  #:amount-in-world 5
                  #:weapon          (my-weapon)))
 
  (survival-game
   #:avatar     (custom-avatar)
   #:enemy-list   (list (my-enemy))))




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
                 #:name            "Apple"
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



 
(define-example-code survival starvation-rate
  (survival-game
   #:avatar          (custom-avatar)
   #:starvation-rate 100))



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


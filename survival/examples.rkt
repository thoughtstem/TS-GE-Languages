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

 
(define-example-code survival basic-avatar
 (define (my-avatar)
   (custom-avatar #:sprite (circle 40 "solid" "red")))

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

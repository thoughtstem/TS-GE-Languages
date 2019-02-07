#lang racket

(require ts-kata-util
         "./lang/main.rkt")

;(define-example-code/from* survival/examples)


(define-example-code survival-minecraft hero-1

  (minecraft-game
   #:skin (custom-skin))
  )

(define-example-code survival-minecraft hero-2 

  (define (my-skin)
    (custom-skin #:sprite (star 30 'solid 'yellow)))
  
  (minecraft-game
   #:skin (my-skin))
  )

(define-example-code survival-minecraft hero-3

  (define (my-skin)
    (custom-skin #:sprite (random-character-sprite)))
  
  (minecraft-game
   #:skin (my-skin))
  )

;CHANGE ME?
(define-example-code survival-minecraft hero-4
  
  (define (my-skin)
    (custom-skin #:sprite STUDENT-IMAGE-HERE))

  (minecraft-game
   #:skin (my-skin))
  )

(define-example-code survival-minecraft hero-5
  
  (define (my-skin)
    (custom-skin #:sprite (sheet->sprite STUDENT-IMAGE-HERE
                                         #:columns 4)))
  
  (minecraft-game
   #:skin (my-skin))
  )

;======================================================

(define-example-code survival-minecraft food-1

  (minecraft-game
   #:skin       (custom-skin)
   #:food-list  (list (custom-food #:amount-in-world 10)))
  )

(define-example-code survival-minecraft food-2
  
  (define (my-food)
    (custom-food #:amount-in-world 5
                 #:heals-by        20))
 
  (minecraft-game
   #:skin       (custom-skin)
   #:food-list  (list (my-food)))
  )


(define-example-code survival-minecraft food-3

  (define (my-food)
    (custom-food #:sprite          apples-sprite
                 #:name            "Apples"
                 #:amount-in-world 5
                 #:heals-by        20))

  (minecraft-game
   #:skin       (custom-skin)
   #:food-list  (list (my-food)))
  )


(define-example-code survival-minecraft food-4

  (define (my-food)
    (custom-food #:sprite          apples-sprite
                 #:name            "Apples"
                 #:amount-in-world 5
                 #:heals-by        20))

  (define (special-food)
    (custom-food #:sprite          cherry-sprite
                 #:name            "Cherry"
                 #:amount-in-world 1
                 #:heals-by        50
                 #:respawn?        #f))

  (minecraft-game
   #:skin       (custom-skin)
   #:food-list  (list (my-food)
                      (special-food)))
  )

;===============================================

(define-example-code survival-minecraft mob-1

  (minecraft-game
   #:skin     (custom-skin)
   #:mob-list (list (custom-mob)))
  )

;as it currently stands, no curry needed. Add back in the following line
;when custom-mob randomizes different sprites:
;(curry custom-mob #:amount-in-world 10)
(define-example-code survival-minecraft mob-2

  (minecraft-game
   #:skin     (custom-skin) 
   #:mob-list (list (custom-mob #:amount-in-world 10)))
  )


(define-example-code survival-minecraft mob-3
  
  (define (my-mob)
    (custom-mob #:ai              'medium
                #:sprite          bat-sprite
                #:amount-in-world 5))
 
  (minecraft-game
   #:skin     (custom-skin)
   #:mob-list (list (my-mob)))
  )

(define-example-code survival-minecraft mob-4

  (define (easy-mob)
    (custom-mob #:ai              'easy
                #:sprite          slime-sprite
                #:amount-in-world 5))
  
  (define (medium-mob)
    (custom-mob #:ai              'medium
                  #:sprite          bat-sprite
                  #:amount-in-world 5
                  #:night-only?     #t))
 
  (minecraft-game
   #:skin     (custom-skin)
   #:mob-list (list (easy-mob) (medium-mob)))
  )

(define-example-code survival-minecraft mob-5
 
  (define (hard-mob)
    (custom-mob #:ai              'hard
                #:sprite          snake-sprite
                #:amount-in-world 5
                #:weapon          (acid-spitter #:damage 50)))
 
  (minecraft-game
   #:skin     (custom-skin)
   #:mob-list (list (hard-mob)))
  )

;=============================================

;ore is broken ATM

#;(define-example-code survival-minecraft ore-1

  (minecraft-game
   #:skin     (custom-skin)
   #:ore-list (list (custom-ore)))
  )

#;(define-example-code survival-minecraft ore-2
  
  (define (my-ore)
    (custom-ore #:value 50))
 
  (minecraft-game
   #:skin     (custom-skin)
   #:ore-list (list (my-ore)))
  )

#;(define-example-code survival-minecraft ore-3
  (define (my-ore)
    (custom-ore #:sprite          gold-ore-sprite
                #:name            "Gold Ore"
                #:value           200
                #:amount-in-world 20))

  (minecraft-game
   #:skin     (custom-skin)
   #:ore-list (list (my-ore)))
  )

#;(define-example-code survival-minecraft ore-4
  
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

;==================================================

(define-example-code survival-minecraft crafter-1

  (minecraft-game
   #:skin         (custom-skin)
   #:crafter-list (list (custom-crafter)))
  )

(define-example-code survival-minecraft crafter-2
  (minecraft-game
   #:skin         (custom-skin)
   #:food-list    (list (carrot #:amount-in-world 10))
   #:crafter-list (list (custom-crafter
                         #:recipe-list (list carrot-stew-recipe)))))

(define-example-code survival-minecraft crafter-3

  (define (fish-stew)
    (custom-food #:name "Fish Stew"
                 #:sprite fish-stew-sprite
                 #:respawn? #f
                 #:heals-by 50))

  (define fish-stew-recipe
    (recipe #:product (fish-stew)
            #:build-time 40
            #:ingredients (list "Fish")))

  (minecraft-game
   #:skin         (custom-skin)
   #:food-list    (list (fish #:amount-in-world 10))
   #:crafter-list (list (custom-crafter #:sprite cauldron-sprite
                                        #:recipe-list (list fish-stew-recipe)))))

(define-example-code survival-minecraft crafter-4
  
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
  
  (minecraft-game
   #:skin         (custom-skin)
   #:food-list    (list (carrot #:amount-in-world 10)
                        (fish   #:amount-in-world 10))
   #:crafter-list (list (my-cauldron))))

;=========================================================

(define-example-code survival-minecraft sky-1 

  (minecraft-game
   #:skin (custom-skin)
   #:sky  (custom-sky #:length-of-day 5000))
   )

(define-example-code survival-minecraft sky-2 

  (minecraft-game
   #:skin (custom-skin)
   #:sky  (custom-sky #:length-of-day 500
                      #:max-darkness  255))
  )

(define-example-code survival-minecraft sky-3 

  (minecraft-game
   #:skin (custom-skin)
   #:sky  (custom-sky #:night-sky-color  'darkmagenta
                      #:max-darkness     150))
  )

(define-example-code survival-minecraft sky-4 

  (minecraft-game
   #:skin     (custom-skin)
   #:mob-list (list (custom-mob #:amount-in-world 20
                                #:night-only? #t))
   #:sky      (custom-sky #:length-of-day    2400
                          #:start-of-daytime 200
                          #:end-of-daytime   2200))
  )

(define-example-code survival-minecraft starvation-rate
  (minecraft-game
   #:skin            (custom-skin)
   #:starvation-rate 100)
  )


;Tests all examples as games for 10 ticks
;(test-all-examples-as-games 'survival-minecraft)




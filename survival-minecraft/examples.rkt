#lang racket

(require ts-kata-util
         "./lang/main.rkt")

(define-example-code/from* survival/examples)

#|
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

(define-example-code survival-minecraft mob-2

  (minecraft-game
   #:skin     (custom-skin) 
   #:mob-list (list (curry custom-mob #:amount-in-world 10)))
  )


(define-example-code survival-minecraft mob-3
  
  (define (my-mob)
    (custom-mob #:ai              'medium
                #:sprite          skeleton-sprite
                #:amount-in-world 5))
 
  (minecraft-game
   #:skin     (custom-skin)
   #:mob-list (list (my-mob)))
  )

(define-example-code survival-minecraft mob-4

  (define (easy-mob)
    (custom-mob #:ai              'easy
                #:sprite          creeper-sprite
                #:amount-in-world 5))
  
  (define (medium-mob)
    (custom-mob #:ai              'medium
                #:sprite          skeleton-sprite
                #:amount-in-world 5
                #:night-only?     #t))
 
  (minecraft-game
   #:skin     (custom-skin)
   #:mob-list (list (easy-mob) (medium-mob)))
  )

(define-example-code survival-minecraft mob-5
 
  (define (hard-mob)
    (custom-mob #:ai              'hard
                #:sprite          ghast-sprite
                #:amount-in-world 5
                #:weapon          (acid-spitter #:damage 50)))
 
  (minecraft-game
   #:skin     (custom-skin)
   #:mob-list (list (hard-mob)))
  )

;=============================================

(define-example-code survival-minecraft ore-1

  (minecraft-game
   #:skin     (custom-skin)
   #:ore-list (list (custom-ore)))
  )

(define-example-code survival-minecraft ore-2
  
  (define (my-ore)
    (custom-ore #:value 50))
 
  (minecraft-game
   #:skin     (custom-skin)
   #:ore-list (list (my-ore)))
  )

(define-example-code survival-minecraft ore-3
  (define (my-ore)
    (custom-ore #:sprite          goldore-sprite
                #:name            "Gold Ore"
                #:value           200
                #:amount-in-world 20))

  (minecraft-game
   #:skin     (custom-skin)
   #:ore-list (list (my-ore)))
  )

(define-example-code survival-minecraft ore-4
  
  (define (gold-ore)
    (custom-coin #:sprite goldore-sprite
                 #:name   "Gold Ore"))

  (define (diamond)
    (custom-coin #:sprite          diamond-sprite
                 #:name            "Diamond"
                 #:value           1000
                 #:amount-in-world 1
                 #:respawn?        #f))

  (minecraft-game
   #:skin     (custom-skin)
   #:ore-list (list (gold-ore)
                    (diamond))))

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

;====================================================

(define-example-code survival-minecraft starvation-rate
  (minecraft-game
   #:skin            (custom-skin)
   #:starvation-rate 100)
  )

;====================================================

(define-example-code survival-minecraft entity-1

  (minecraft-game
   #:skin (custom-skin)
   #:entity-list (list (custom-entity))))

(define-example-code survival-minecraft entity-2

  (define (my-entity)
    (custom-entity
     #:sprite pig-sprite
     #:name "Miss Piggy"))

  (minecraft-game
   #:skin (custom-skin)
   #:entity-list (list (my-entity))))


(define-example-code survival-minecraft entity-3
  (define (my-entity)
    (custom-entity
     #:sprite pig-sprite
     #:name "Sir Pigsnoot"
     #:tile 3
     #:mode 'follow))

  (minecraft-game
   #:skin (custom-skin)
   #:entity-list (list (my-entity))))


(define-example-code survival-minecraft entity-4
  (define (my-entity)
    (custom-entity
     #:dialog (list "Woah, who are you??"
                    "Wait, I'm a chicken..."
                    "I can't talk!")))
  (minecraft-game
   #:skin (custom-skin)
   #:entity-list (list (my-entity))))


(define-example-code survival-minecraft entity-5
  (define (my-entity)
    (custom-entity
     #:name "Francis"
     #:tile 4
     #:dialog (list "Greetings!"
                    "Gee, you look hungry."
                    "I'd offer you some chicken feed...\nbut I don't think you'd like it.")))

  (define (another-entity)
    (custom-entity
     #:sprite pig-sprite
     #:name "Mr. Piggstockerton III"
     #:mode 'pace
     #:dialog (list "oink oink oink oink"
                    "oink OINK OINK"
                    "oooOIINK")))

  (minecraft-game
   #:skin (custom-skin)
   #:entity-list (list (my-entity) (another-entity))))


;==========================================================

(define-example-code survival-minecraft biome-1

  (minecraft-game
   #:skin (custom-skin)
   #:biome (custom-biome))
  )


(define-example-code survival-minecraft biome-2
  (minecraft-game
   #:skin (custom-skin)
   #:biome (custom-biome #:image DESERT-BG))
  )


(define-example-code survival-minecraft biome-3
  (define (my-biome)
    (custom-biome
     #:image LAVA-BG
     #:start-tile 4))

  (minecraft-game
   #:skin (custom-skin)
   #:biome (my-biome))
  )
|#

;Tests all examples as games for 10 ticks
;(test-all-examples-as-games 'survival-minecraft)




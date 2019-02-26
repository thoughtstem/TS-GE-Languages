#lang racket

(require ts-kata-util battle-arena)


(define-example-code battle-arena hello-world-1
  (battle-arena-game)
  )

; ---------------

(define-example-code battle-arena force-field-1
  (battle-arena-game
   #:item-list (list (custom-item #:name "Force Field"
                                  #:on-use (spawn (force-field)))))
  )

(define-example-code battle-arena force-field-2
  (battle-arena-game
   #:item-list (list (custom-item #:name "Force Field"
                                  #:sprite (make-icon "FF")
                                  #:on-use (spawn (force-field #:duration 1000)))))
  )

(define-example-code battle-arena force-field-3
  (define (force-field-item)
    (custom-item #:name "Force Field"
                 #:sprite (make-icon "FF")
                 #:on-use (spawn (force-field #:allow-friendly-dart? #t
                                              #:duration 1000))))
 
  (battle-arena-game
    #:item-list (list (force-field-item)))
  )

;-----------------

(define-example-code battle-arena avatar-1
  (battle-arena-game
   #:avatar (custom-avatar))
  )

(define-example-code battle-arena avatar-2
  (battle-arena-game
   #:avatar (custom-avatar #:sprite pirateboy-sprite))
  )

(define-example-code battle-arena avatar-3
  (define (my-avatar)
    (custom-avatar #:sprite pirategirl-sprite
                   #:speed 20))
  
  (battle-arena-game
   #:avatar (my-avatar))
  )

(define-example-code battle-arena avatar-4
  (define (my-avatar)
    (custom-avatar #:sprite steampunkgirl-sprite
                   #:speed 20
                   #:item-slots 5))
  
  (battle-arena-game
   #:avatar (my-avatar))
  )

;-----------------

(define-example-code battle-arena enemy-1
  (battle-arena-game
   #:enemy-list (list (custom-enemy)))
  )

(define-example-code battle-arena enemy-2
  (battle-arena-game
   #:enemy-list (list (curry custom-enemy #:amount-in-world 10)))
  )

(define-example-code battle-arena enemy-3
  (define (my-enemy)
    (custom-enemy #:sprite          darkknight-sprite
                  #:ai              'medium
                  #:amount-in-world 5))

  (battle-arena-game
   #:enemy-list (list (my-enemy)))
  )

;Tip: you can also change shield instead of health
(define-example-code battle-arena enemy-4
  (define (easy-enemy)
    (custom-enemy #:ai              'easy
                  #:sprite          wizard-sprite
                  #:health          50
                  #:amount-in-world 5))
  
  (define (medium-enemy)
    (custom-enemy #:ai              'medium
                  #:sprite          darkknight-sprite
                  #:health          200
                  #:amount-in-world 5))
 
  (battle-arena-game
   #:enemy-list (list (easy-enemy)
                      (medium-enemy))))

(define-example-code battle-arena enemy-5
 
  (define (hard-enemy)
    (custom-enemy #:ai              'hard
                  #:sprite          pirategirl-sprite
                  #:amount-in-world 5
                  #:weapon          (custom-weapon #:damage 50)))
 
  (battle-arena-game
   #:avatar       (custom-avatar)
   #:enemy-list   (list (hard-enemy))))

;-----------------

(define-example-code battle-arena enemy-weapon-1
  (battle-arena-game
   #:enemy-list (list (custom-enemy
                       #:weapon (sword))))
  )

(define-example-code battle-arena enemy-weapon-2
  (define (my-weapon)
    (sword #:damage 40))

  (battle-arena-game
   #:enemy-list (list (custom-enemy
                       #:weapon (my-weapon))))
  )

(define-example-code battle-arena enemy-weapon-3
  (define (my-dart)
    (custom-dart
     #:damage 5
     #:speed  1
     #:range  200))

  (define (my-weapon)
    (custom-weapon
     #:name      "Repeator"
     #:dart      (my-dart)))

  (battle-arena-game
   #:enemy-list (list (custom-enemy
                       #:weapon (my-weapon))))
  )

;-----------------

;Tip: defaults: damage = 25, durability = 20, range = 10
(define-example-code battle-arena sword-1
  (battle-arena-game
   #:weapon-list (list (sword)))
  )

(define-example-code battle-arena sword-2
  (battle-arena-game
   #:weapon-list (list (sword #:name "Heavy Sword"
                              #:damage 50)))
  )

; Tip: common = 5, uncommon = 4, rare = 3, epic = 2, legendary = 1
(define-example-code battle-arena sword-3
  (define (my-sword)
    (sword #:name   "Epic Heavy Sword"
           #:damage 50
           #:rarity 'epic))
  
  (battle-arena-game
   #:weapon-list (list (my-sword))))

; Tip: try different colors like: 'red 'lightblue 'darkmagenta
(define-example-code battle-arena sword-4
  (define (my-sword)
    (sword #:name   "Legendary Sword"
           #:icon   (make-icon "LS" 'gold)
           #:sprite (set-sprite-color swinging-sword-sprite #:color 'gold)
           #:damage 100
           #:duration  100
           #:rarity 'legendary))
  
  (battle-arena-game
   #:weapon-list (list (my-spear)))
  )

;-----------------

(define-example-code battle-arena background-1  
  (battle-arena-game
   #:bg (custom-bg))
  )

(define-example-code battle-arena background-2
  (battle-arena-game #:bg (custom-bg #:img LAVA-BG))
  )

(define-example-code battle-arena background-3
  (define (my-bg)
    (custom-bg #:img LAVA-BG
               #:rows 2
               #:columns 2
               #:start-tile 4))
 
  (battle-arena-game #:bg (my-bg))
  )

;-----------------


(define-example-code battle-arena boost-1
  (battle-arena-game
   #:item-list (list (custom-item #:name   "Damage Boost"
                                  #:sprite (make-icon "DB" 'orangered)
                                  #:on-use (change-damage-by 1000 #:for 200))))
  )

(define-example-code battle-arena boost-2
  (battle-arena-game
   #:item-list (list (custom-item #:name   "Speed Boost"
                                  #:sprite (make-icon "SB" 'yellow)
                                  #:on-use (multiply-speed-by 2 #:for 200))))
  )

(define-example-code battle-arena boost-3
  (define (damage-boost)
    (custom-item #:name   "Damage Boost"
                 #:sprite (make-icon "DB" 'orangered)
                 #:on-use (change-damage-by 1000 #:for 200)
                 #:rarity 'epic))

  (define (speed-boost)
    (custom-item #:name   "Speed Boost"
                 #:sprite (make-icon "SB" 'yellow)
                 #:on-use (multiply-speed-by 2 #:for 200)
                 #:rarity 'uncommon))
  
  (battle-arena-game
   #:item-list (list (damage-boost)
                     (speed-boost)))
  )

;-----------------

(define-example-code battle-arena dagger-tower-1
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Dagger Tower"
                        #:sprite (make-icon "RT")
                        #:dart (dagger-tower-builder)))))

(define-example-code battle-arena dagger-tower-2
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Dagger Tower"
                        #:sprite (make-icon "RT")
                        #:dart (dagger-tower-builder
                                #:speed      10
                                #:fire-mode  'spread)))))

(define-example-code battle-arena dagger-tower-3
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Dagger Tower"
                        #:sprite (make-icon "RT")
                        #:dart (dagger-tower-builder
                                #:sprite     STUDENT-IMAGE-HERE
                                #:damage     1000
                                #:speed      10
                                #:fire-mode  'spread)))))

;-----------------


(define-example-code battle-arena size-1
  
  (battle-arena-game
   #:item-list (list (custom-item #:name   "Grow Powerup"
                                  #:sprite (make-icon "BIG" 'red 'white)
                                  #:on-use (scale-sprite 2 #:for 100)))))

(define-example-code battle-arena size-2

  (battle-arena-game
   #:item-list (list (custom-item #:name   "Shrink Powerup"
                                  #:sprite (make-icon "SML" 'blue 'white)
                                  #:on-use (scale-sprite 0.5 #:for 100)))))

(define-example-code battle-arena size-3

  (define (grow-powerup)
    (custom-item #:name   "Grow Powerup"
                 #:sprite (make-icon "BIG" 'red 'white)
                 #:on-use (scale-sprite 2 #:for 100)
                 #:rarity 'common))

  (define (shrink-powerup)
    (custom-item #:name     "Shrink Powerup"
                 #:sprite   (make-icon "SML" 'blue 'white)
                 #:on-use   (scale-sprite 0.5 #:for 100)
                 #:rarity   'rare))
  
  (battle-arena-game
   #:item-list      (list (grow-powerup)
                          (shrink-powerup))))



(define-example-code battle-arena health-1
  
  (battle-arena-game
   #:item-list (list (custom-item #:name   "Health Powerup"
                                  #:sprite (make-icon "HP" 'green 'white)
                                  #:on-use (change-health-by 50)))))



(define-example-code battle-arena health-2
  
  (battle-arena-game
   #:item-list (list (custom-item #:name   "Max Health Powerup"
                                  #:sprite (make-icon "MHP" 'green 'white)
                                  #:on-use (set-health-to 100)))))



(define-example-code battle-arena health-3

  (define (health-powerup)
    (custom-item #:name     "Health Powerup"
                 #:sprite   (make-icon "HP" 'green 'white)
                 #:on-use   (change-health-by 50)
                 #:rarity   'uncommon
                 #:respawn? #t))
  
  (define (max-health-powerup)
    (custom-item #:name   "Max Health Powerup"
                 #:sprite (make-icon "MHP" 'green 'white)
                 #:on-use (set-health-to 100)
                 #:rarity 'epic))
  
  (battle-arena-game
   #:item-list      (list (health-powerup)
                          (max-health-powerup))))



(define-example-code battle-arena homing-repeater-1
  (battle-arena-game
   #:weapon-list    (list (custom-weapon #:name "Homing Repeater"
                                         #:sprite (make-icon "HR")
                                         #:fire-mode 'homing))))



(define-example-code battle-arena homing-repeater-2

  (define (homing-dart)
    (custom-dart #:damage 15
                 #:speed  8
                 #:range  40))
  
  (battle-arena-game
   #:weapon-list    (list (custom-weapon #:name      "Homing Repeater"
                                         #:sprite    (make-icon "HR")
                                         #:fire-mode 'homing
                                         #:dart      (homing-dart)))))



(define-example-code battle-arena homing-repeater-3

  (define (homing-dart)
    (custom-dart #:sprite (rectangle 10 2 'solid 'pink)
                 #:damage 15
                 #:speed  8
                 #:range  40))

  (define (hoaming-shot)
    (custom-weapon #:name      "Homing Repeater"
                   #:sprite    (make-icon "HR")
                   #:fire-mode 'homing
                   #:dart      (homing-dart)
                   #:rarity    'epic))
  
  (battle-arena-game
   #:weapon-list    (list (hoaming-shot))))



(define-example-code battle-arena lava-pit-1
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Lava Pit"
                        #:sprite (make-icon "LP")
                        #:dart (lava-builder)))))



(define-example-code battle-arena lava-pit-2
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Lava Pit"
                        #:sprite (make-icon "LP" 'red)
                        #:dart (lava-builder
                                #:damage 25
                                #:size   2)))))



(define-example-code battle-arena lava-pit-3
  (define (my-lava-pit)
    (custom-weapon #:name "Lava Pit"
                   #:sprite (make-icon "LP" 'red 'white)
                   #:dart (lava-builder #:damage  25
                                        #:size    1
                                        #:sprite  (square 10 'solid 'black)
                                        #:range   10)))
  (battle-arena-game
   #:weapon-list (list (my-lava-pit)))
  )



(define-example-code battle-arena magic-balance-1
  (battle-arena-game
   #:weapon-list (list (ring-of-fire #:name "Light Magic"
                                     #:icon (make-icon "LM")
                                     #:damage 20
                                     #:rarity 'common))))


;Tip: also try ring-of-ice
(define-example-code battle-arena magic-balance-2
  (battle-arena-game
   #:weapon-list (list (ring-of-fire #:name "Heavy Magic"
                                     #:icon   (make-icon "HM")
                                     #:sprite (scale 2 flame-sprite)
                                     #:damage 200
                                     #:rarity 'epic))))

(define-example-code battle-arena magic-balance-3
  (define (heavy-magic)
    (ring-of-fire #:name   "Heavy Magic"
                  #:icon   (make-icon "HM")
                  #:sprite (scale 2 flame-sprite)
                  #:damage 200
                  #:rarity 'epic))

  (define (light-magic)
    (ring-of-fire #:name     "Light Magic"
                  #:sprite   (make-icon "LM")
                  #:damage   20
                  #:duration 20
                  #:rarity   'common
                  ))
  
  (battle-arena-game
   #:weapon-list (list (heavy-magic)
                       (light-magic)))
  )


(define-example-code battle-arena melee-balance-1
  (battle-arena-game
   #:weapon-list (list (sword #:name "Light Sword"
                              #:icon (make-icon "LS")
                              #:damage 10
                              #:rarity 'common))))

(define-example-code battle-arena melee-balance-2
  (battle-arena-game
   #:weapon-list (list (sword #:name "Heavy Sword"
                              #:icon (make-icon "HS")
                              #:sprite (scale 2 swinging-sword-sprite)
                              #:damage 200
                              #:rarity 'epic))))

(define-example-code battle-arena melee-balance-3
  (define (heavy-sword)
    (sword #:name "Heavy Sword"
           #:icon (make-icon "HS")
           #:sprite (scale 2 swinging-sword-sprite)
           #:damage 200
           #:rarity 'epic))

  (define (light-sword)
    (sword #:name "Light Sword"
           #:icon (make-icon "LS")
           #:damage 10
           #:rarity 'common))
  
  (battle-arena-game
   #:weapon-list (list (heavy-sword)
                       (light-sword)))
  )


(define-example-code battle-arena paint-thrower-1
  
  (battle-arena-game
   #:weapon-list (list (paint-thrower)))
  )

(define-example-code battle-arena paint-thrower-2
  (define (my-weapon)
    (paint-thrower #:name   "Heavy Paint Thrower"
                   #:damage 20))
  
  (battle-arena-game
   #:weapon-list (list (my-weapon)))
  )

(define-example-code battle-arena paint-thrower-3
  (define (my-weapon)
    (paint-thrower #:name   "Epic Paint Thrower"
                   #:icon (make-icon "PT" 'blue)
                   #:damage 20
                   #:speed  10
                   #:rarity 'epic))
  
  (battle-arena-game
   #:weapon-list (list (my-weapon)))
  )

(define-example-code battle-arena paint-thrower-4
  (define (my-weapon)
    (paint-thrower #:name   "Legendary Paint Thrower"
                   #:icon   (make-icon "PT" 'blue)
                   #:sprite (set-sprite-color 'green paint-sprite)
                   #:damage  20
                   #:speed   10
                   #:range   50
                   #:rarity  'legendary))

  (battle-arena-game
   #:weapon-list (list (my-weapon)))
  )



(define-example-code battle-arena repeater-armor-1
  
  (battle-arena-game
   #:item-list (list (custom-armor #:name   "Repeater Armor"
                                   #:sprite (make-icon "RA"))))

  
  )




(define-example-code battle-arena repeater-armor-2
  
  (battle-arena-game
   #:item-list (list (custom-armor #:name          "Repeater Armor"
                                   #:sprite        (make-icon "RA")
                                   #:protects-from "Repeater"
                                   #:change-damage (divide-by 2)
                                   #:rarity        'rare
                                   )))

  
  )




(define-example-code battle-arena repeater-armor-3
  
  (battle-arena-game
   #:enemy-list (list (custom-enemy #:amount-in-world 10
                                    #:weapon          (custom-weapon
                                                       #:name "Repeater")))
   #:item-list (list (custom-armor #:name          "Repeater Armor"
                                   #:sprite        (make-icon "RA")
                                   #:protects-from "Repeater"
                                   #:change-damage (divide-by 2)
                                   #:rarity        'rare)))

  
  ) 



(define-example-code battle-arena repeater-balance-1
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name "Light Repeater"
                                      #:dart (custom-dart #:sprite paint-sprite
                                                          #:damage 20
                                                          #:durability 1
                                                          #:speed  30
                                                          #:range  50)
                                      #:rarity 'common))))

(define-example-code battle-arena repeater-balance-2
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name "Heavy Repeater"
                                      #:dart (custom-dart #:sprite (scale 2 paint-sprite)
                                                          #:damage 500
                                                          #:durability 100
                                                          #:speed  10
                                                          #:range  50)
                                      #:rarity 'uncommon))))

(define-example-code battle-arena repeater-balance-3
  (define (heavy-dart)
    (custom-dart #:sprite (scale 2 paint-sprite)
                 #:damage 500
                 #:durability 100
                 #:speed  10
                 #:range  50))

  (define (light-dart)
    (custom-dart #:sprite paint-sprite
                 #:damage 20
                 #:durability 1
                 #:speed  30
                 #:range  50))
  
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name "Heavy Repeater"
                                      #:dart (heavy-dart)
                                      #:rarity 'uncommon)
                       (custom-weapon #:name "Light Repeater"
                                      #:dart (light-dart)
                                      #:rarity 'common))))



(define-example-code battle-arena repeater-tower-1
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Repeater Tower"
                        #:sprite (make-icon "RT")
                        #:dart (repeater-tower-builder)))))



(define-example-code battle-arena repeater-tower-2
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Repeater Tower"
                        #:sprite (make-icon "RT")
                        #:dart (repeater-tower-builder
                                #:speed      2
                                #:fire-rate  10)))))



(define-example-code battle-arena repeater-tower-3
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Repeater Tower"
                        #:sprite (make-icon "RT")
                        #:dart (repeater-tower-builder
                                #:sprite     STUDENT-IMAGE-HERE
                                #:speed      15
                                #:damage     1000
                                #:range      500
                                #:fire-rate  0.1)))))



(define-example-code battle-arena rocket-tower-1
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Rocket Tower"
                        #:sprite (make-icon "RT")
                        #:dart (rocket-tower-builder)))))



(define-example-code battle-arena rocket-tower-2
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Rocket Tower"
                        #:sprite (make-icon "RT")
                        #:dart (rocket-tower-builder
                                #:speed      2
                                #:fire-mode  'homing)))))



(define-example-code battle-arena rocket-tower-3
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Rocket Tower"
                        #:sprite (make-icon "RT")
                        #:dart (rocket-tower-builder
                                #:sprite     STUDENT-IMAGE-HERE
                                #:range      200
                                #:damage     1000
                                #:speed      2
                                #:fire-mode  'homing)))))




(define-example-code battle-arena shield-1
  (battle-arena-game
   #:item-list (list (custom-item #:name     "Shield Powerup" 
                                  #:sprite   (make-icon "SP" 'blue 'white)
                                  #:on-use   (change-shield-by 50))))
  )





(define-example-code battle-arena shield-2
  (battle-arena-game
   #:item-list (list (custom-item #:name     "Max Shield Powerup"
                                  #:sprite   (make-icon "MSP" 'blue 'white)
                                  #:on-use   (set-shield-to 100))))
  )





(define-example-code battle-arena shield-3

  (define (shield-powerup)
    (custom-item #:name     "Shield Powerup" 
                 #:sprite   (make-icon "SP" 'blue 'white)
                 #:on-use   (change-shield-by 50)
                 #:rarity   'uncommon
                 #:respawn? #t))

  (define (max-shield)
    (custom-item #:name     "Max Shield Powerup"
                 #:sprite   (make-icon "MSP" 'blue 'white)
                 #:on-use   (set-shield-to 100)
                 #:rarity   'epic))
  
  (battle-arena-game
   #:item-list (list (shield-powerup)
                     (max-shield)))
  )








(define-example-code battle-arena single-shot-1
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name        "Single Shot"
                                      #:sprite      (make-icon "SS")
                                      #:rapid-fire? #f))))

(define-example-code battle-arena single-shot-2

  (define (single-dart)
    (custom-dart #:damage 10
                 #:speed  10
                 #:range  50))
  
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name      "Single Shot"
                                      #:sprite    (make-icon "SS")
                                      #:fire-mode 'normal
                                      #:dart      (single-dart)))))



(define-example-code battle-arena single-shot-3

  (define (single-dart)
    (custom-dart #:sprite (rectangle 10 2 'solid 'cyan)
                 #:damage 10
                 #:speed  10
                 #:range  50))

  (define (single-shot)
    (custom-weapon #:name        "Single Shot"
                   #:sprite      (make-icon "SS")
                   #:fire-mode   'normal
                   #:dart        (single-dart)
                   #:rapid-fire? #f
                   #:rarity      'common))
  
  (battle-arena-game
   #:weapon-list (list (single-shot))))


;Tip: defaults: damage = 50, speed = 5, range 20
(define-example-code battle-arena spear-1
  (battle-arena-game
   #:weapon-list (list (spear)))
  )

(define-example-code battle-arena spear-2
  (battle-arena-game
   #:weapon-list (list (spear #:name "Heavy Spear"
                              #:damage 50)))
  )

; Tip: common = 5, uncommon = 4, rare = 3, epic = 2, legendary = 1
(define-example-code battle-arena spear-3
  (define (my-spear)
    (spear #:name   "Epic Heavy Spear"
           #:damage 50
           #:rarity 'epic))
  
  (battle-arena-game
   #:weapon-list (list (my-spear))))

; Tip: try different colors like: 'red 'lightblue 'darkmagenta
(define-example-code battle-arena spear-4
  (define (my-spear)
    (spear #:name   "Legendary Spear"
           #:icon   (make-icon "LS" 'blue)
           #:sprite (new-sprite SPEAR-IMG #:color 'blue)
           #:damage 100
           #:speed 20
           #:range 10
           #:rarity 'legendary))
  
  (battle-arena-game
   #:weapon-list (list (my-spear)))
  )

(define-example-code battle-arena spear-tower-1
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Spear Tower"
                        #:sprite (make-icon "ST")
                        #:dart (spear-tower-builder)))))

(define-example-code battle-arena spear-tower-2
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "ST"
                        #:sprite (make-icon "ST" 'tan)
                        #:dart (spear-tower-builder
                                #:speed 10 
                                #:range 50)))))

(define-example-code battle-arena spear-tower-3
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Spear Tower"
                        #:sprite (make-icon "ST" 'tan 'white)
                        #:dart (spear-tower-builder
                                #:sprite STUDENT-IMAGE-HERE
                                #:damage 100
                                #:speed 10
                                #:range 50)))))



#;(define-example-code battle-arena spear-tower-builder-1
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:dart (spear-tower-builder)))))





(define-example-code battle-arena spike-mine-1
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Spike Mine"
                        #:sprite (make-icon "SM")
                        #:dart (spike-mine-builder)))))



(define-example-code battle-arena spike-mine-2
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Spike Mine"
                        #:sprite (make-icon "SM" 'gray)
                        #:dart (spike-mine-builder
                                #:speed 10 
                                #:range 50)))))



(define-example-code battle-arena spike-mine-3
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Spike Mine"
                        #:sprite (make-icon "SM" 'gray 'white)
                        #:dart (spike-mine-builder
                                #:sprite STUDENT-IMAGE-HERE
                                #:damage 100
                                #:speed 10
                                #:range 50)))))


(define-example-code battle-arena spread-shot-1
  (battle-arena-game
   #:weapon-list    (list (custom-weapon #:name      "Spread Shot"
                                         #:sprite    (make-icon "SPR")
                                         #:fire-mode 'spread))))



(define-example-code battle-arena spread-shot-2

  (define (spread-dart)
    (custom-dart #:damage     20
                 #:durability 20
                 #:speed      15))
  
  (battle-arena-game
   #:weapon-list    (list (custom-weapon #:name      "Spread Shot"
                                         #:sprite    (make-icon "SPR")
                                         #:fire-mode 'spread
                                         #:dart      (spread-dart)))))



(define-example-code battle-arena spread-shot-3

  (define (spread-dart)
    (custom-dart #:sprite     (rectangle 10 2 'solid 'orange)
                 #:damage     20
                 #:durability 20
                 #:speed      15))

  (define (spread-shot)
    (custom-weapon #:name      "Spread Shot"
                   #:sprite    (make-icon "SPR")
                   #:fire-mode 'spread
                   #:dart      (spread-dart)
                   #:rarity    'rare))
  
  (battle-arena-game
   #:weapon-list    (list (spread-shot))))









(define-example-code battle-arena sword-armor-1
  
  (battle-arena-game
   #:item-list (list (custom-armor #:name   "Sword Armor"
                                   #:sprite (make-icon "SA"))))

  
  )




(define-example-code battle-arena sword-armor-2
  
  (battle-arena-game
   #:item-list (list (custom-armor #:name   "Sword Armor"
                                   #:sprite (make-icon "SA")
                                   #:protects-from "Sword"
                                   #:change-damage (subtract-by 30)
                                   #:rarity 'rare)))

  
  )




(define-example-code battle-arena sword-armor-3
  
  (battle-arena-game
   #:enemy-list (list (custom-enemy #:amount-in-world 10
                                    #:weapon       (sword)))
   #:item-list (list (custom-armor #:name          "Sword Armor"
                                   #:sprite        (make-icon "RA")
                                   #:protects-from "Sword"
                                   #:change-damage (divide-by 2)
                                   #:rarity        'rare)))

  
  )



(define-example-code battle-arena wall-builder
  (battle-arena-game
   #:enemy-list (list (custom-enemy #:amount-in-world 20))
   #:weapon-list (list (custom-weapon
                        #:dart (builder-dart #:entity
                                             (wall))))))





(test-all-examples-as-games 'battle-arena)





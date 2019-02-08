#lang racket

(require ts-kata-util battle-arena)


(define-example-code battle-arena avatar-1
  (battle-arena-game
   #:avatar (custom-avatar)))


(define-example-code battle-arena avatar-2
  
  (battle-arena-game
   #:avatar (custom-avatar #:sprite (circle 30 'solid 'blue))))



(define-example-code battle-arena avatar-3

  (define (my-avatar)
    (custom-avatar #:sprite (random-character-sprite)))
  
  (battle-arena-game
   #:avatar (my-avatar)))



(define-example-code battle-arena avatar-3b

  (define (my-avatar)
    (custom-avatar #:sprite (sheet->sprite STUDENT-IMAGE-HERE
                                           #:columns 3)))
  
  (battle-arena-game
   #:avatar (my-avatar)))



(define-example-code battle-arena avatar-3c

  (define (my-avatar)
    (custom-avatar #:sprite     STUDENT-IMAGE-HERE
                   #:key-mode   'wasd
                   #:mouse-aim? #t))
  
  (battle-arena-game
   #:avatar (my-avatar)))




(define-example-code battle-arena avatar-4
  
  (define (my-avatar)
    (custom-avatar #:sprite (sheet->sprite STUDENT-IMAGE-HERE
                                           #:columns 4)))
   
  (battle-arena-game
   #:avatar (my-avatar))
  )

(define-example-code battle-arena battle-gear-armor
  (battle-arena-game
   #:avatar         (custom-avatar #:sprite (random-character-sprite))
   #:enemy-list     (list (custom-enemy #:ai 'medium
                                        #:amount-in-world 10
                                        #:weapon (custom-weapon #:name "Light Repeater"
                                                                #:dart (custom-dart #:damage 20)))
                          (custom-enemy #:ai 'hard
                                        #:amount-in-world 10
                                        #:weapon (custom-weapon #:name "Heavy Sword"
                                                                #:dart (sword #:damage 50))))
   #:item-list      (list (custom-armor #:name          "Repeater Armor"
                                        #:sprite        (make-icon "RA")
                                        #:protects-from "Light Repeater"
                                        #:change-damage (divide-by 10)
                                        #:rarity         'rare
                                        )
                          (custom-armor #:name "Sword Armor"
                                        #:sprite (make-icon "SA")
                                        #:protects-from "Heavy Sword"
                                        #:change-damage (subtract-by 45)
                                        #:rarity 'rare
                                        )
                          )))


(define-example-code battle-arena battle-gear-powerups-and-potions
  (battle-arena-game
   #:avatar         (custom-avatar #:sprite (random-character-sprite)
                                   #:item-slots 3)
   #:enemy-list     (list (custom-enemy #:ai 'easy
                                        #:amount-in-world 10))
   #:weapon-list    (list (custom-weapon))
   #:item-list      (list (custom-item #:name   "Speed Boost"
                                       #:sprite (make-icon "SB" 'yellow)
                                       #:on-use (multiply-speed-by 2 #:for 200)
                                       #:rarity 'common)
                          (custom-item #:name   "Damage Boost"
                                       #:sprite (make-icon "DB" 'orangered)
                                       #:on-use (change-damage-by 100 #:for 200)
                                       #:rarity 'rare)
                          (custom-item #:name   "Damage Multiplier"
                                       #:sprite (make-icon "DM" 'orange 'red)
                                       #:on-use (multiply-damage-by 10 #:for 200)
                                       #:rarity 'epic)
                          #;(custom-item #:name   "Weapon Boost"
                                         #:sprite (make-icon "WB" 'lightblue)
                                         #:on-use (multiply-fire-rate-by 2 #:for 100))
                          (custom-item #:name     "Health Potion"
                                       #:sprite   (make-icon "HP" 'green 'white)
                                       #:on-use   (change-health-by 50)
                                       #:rarity   'uncommon
                                       #:respawn? #t)
                          (custom-item #:name     "Shield Potion"
                                       #:sprite   (make-icon "SP" 'blue 'white)
                                       #:on-use   (change-shield-by 50)
                                       #:rarity   'uncommon
                                       #:respawn? #t)
                          (custom-item #:name     "Max Health Potion"
                                       #:sprite   (make-icon "MHP" 'green 'white)
                                       #:on-use   (set-health-to 100)
                                       #:rarity   'epic)
                          (custom-item #:name     "Max Shield Potion"
                                       #:sprite   (make-icon "MSP" 'blue 'white)
                                       #:on-use   (set-shield-to 100)
                                       #:rarity   'epic)
                          (custom-item #:name     "Grow Potion"
                                       #:sprite   (make-icon "BIG" 'red 'white)
                                       #:on-use   (scale-sprite 2 #:for 100)
                                       #:rarity   'common)
                          (custom-item #:name     "Shrink Potion"
                                       #:sprite   (make-icon "SML" 'blue 'white)
                                       #:on-use   (scale-sprite 0.5 #:for 100)
                                       #:rarity   'common)
                          )))




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



(define-example-code battle-arena enemy-1
  (battle-arena-game
   #:enemy-list (list (custom-enemy)))
  )



(define-example-code battle-arena enemy-2
  (define (my-enemy)
    (custom-enemy #:ai              'easy
                  #:health          200
                  #:shield          100
                  #:amount-in-world 10))

  (battle-arena-game
   #:enemy-list (list (my-enemy)))
  )



(define-example-code battle-arena enemy-3-bonus
  (define (my-enemy)
    (custom-enemy #:sprite          (sheet->sprite STUDENT-IMAGE-HERE
                                                   #:columns 4)
                  #:ai              'easy
                  #:health          200
                  #:shield          100
                  #:amount-in-world 10))

  (battle-arena-game
   #:enemy-list (list (my-enemy)))
  )



(define-example-code battle-arena enemy-3
  (define (my-enemy)
    (custom-enemy #:sprite          (star 30 'solid 'gold)
                  #:ai              'easy
                  #:health          200
                  #:shield          100
                  #:amount-in-world 10))

  (battle-arena-game
   #:enemy-list (list (my-enemy)))
  )




(define-example-code battle-arena enemy-4
  (define (my-enemy)
    (custom-enemy #:sprite          (sheet->sprite STUDENT-IMAGE-HERE
                                                   #:columns 4)
                  #:ai              'easy
                  #:health          200
                  #:shield          100
                  #:amount-in-world 10))
   
  (battle-arena-game
   #:enemy-list (list (my-enemy)))
  )



(define-example-code battle-arena enemy-weapon-1
(battle-arena-game
 #:enemy-list (list (custom-enemy
                     #:weapon (custom-weapon
                               #:dart (sword))))))



(define-example-code battle-arena enemy-weapon-2
  
(define (my-weapon)
  (custom-weapon
   #:name      "Sword"
   #:dart      (sword #:damage 40)))

(battle-arena-game
 #:enemy-list (list (custom-enemy
                     #:weapon (my-weapon)))))



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
                     #:weapon (my-weapon)))))



; ======= FORTNITE BATTLE GEAR - PAINTBALL WEAPONS =======
#;(fortnite2d-game
 #:bg              (custom-background)
 #:avatar          (custom-avatar #:sprite      (row->sprite (random-character-row))
                                  #:key-mode    'wasd
                                  #:mouse-aim?  #t
                                  #:weapon-slots 3)
 #:enemy-list      (list (custom-enemy #:sprite (row->sprite (random-character-row))
                                       #:amount-in-world 10
                                       #:ai     'easy
                                       #:weapon (heavy-repeater)
                                       #:health 200)
                         (custom-enemy #:sprite (row->sprite (random-character-row))
                                       #:amount-in-world 20
                                       #:ai 'hard))
 #:weapon-list     (list (custom-weapon #:name "Light Sword"
                                        #:sprite sword-sprite
                                        #:bullet (sword )
                                        #:rapid-fire? #f
                                        #:rarity 'common)
                         (custom-weapon #:name "Legendary Heavy Spear"
                                        #:sprite spear-sprite
                                        #:bullet (spear-bullet #:damage 100 #:durabiity 50)
                                        #:rapid-fire? #f
                                        #:rarity 'legendary)
                         (custom-weapon #:name "Light Repeater"
                                        #:sprite repeater-sprite
                                        #:bullet (custom-bullet #:damage 5 #:durability 20)
                                        #:fire-rate 10
                                        #:rarity 'uncommon)
                         (custom-weapon #:name "Epic Rocket Launcher"
                                        #:sprite rocket-launcher-sprite
                                        #:bullet (rocket #:damage 50 #:durability 10)
                                        #:fire-rate 1.5
                                        #:fire-mode 'homing
                                        #:rarity 'epic)
                         (custom-weapon #:name      "Ring of Fire Spell"
                                        #:sprite    spell-book-sprite
                                        #:bullet    (flame #:damage 5 #:durability 20)
                                        #:fire-rate 30
                                        #:fire-mode 'random
                                        #:rarity    'rare)))



(define-example-code battle-arena fortnite-melee-battle-advanced
  (define (my-spear)
    (custom-dart #:position (posn 20 0)
                 #:sprite spear-sprite
                 #:damage 50
                 #:durability 50
                 #:speed 5
                 #:range 20
                 #:components (on-start (set-rotation-style 'normal))
                 (after-time 10 (bounce))))

  (define (my-sword)
    (custom-dart #:position (posn 10 0)
                 #:sprite swinging-sword-sprite
                 #:damage 50
                 #:durability 20
                 #:speed  0
                 #:range  10
                 #:components (every-tick (change-direction-by 15))))

  (define (my-paint)
    (custom-dart #:position (posn 25 0)
                 #:sprite paint-sprite
                 #:damage 5
                 #:durability 5
                 #:speed  3
                 #:range  15
                 #:components (on-start (set-size 0.5))
                 (every-tick (scale-sprite 1.1))
                 ))

  (define (my-flying-dagger)
    (custom-dart #:position (posn 20 0)
                 #:sprite   flying-sword-sprite
                 #:damage 10
                 #:speed  2
                 #:range  40
                 #:durability 20
                 #:components (on-start (do-many (set-size 0.5)))
                 (do-every 10 (random-direction 0 360))))

  (define (my-ring-of-fire)
    (custom-dart #:position   (posn 25 0)
                 #:sprite     flame-sprite
                 #:damage     5
                 #:durability 20
                 #:speed      10
                 #:range      36
                 #:components (on-start (set-size 0.5))
                 (every-tick (do-many (scale-sprite 1.05)
                                      (change-direction-by 10)))))

  (battle-arena-game
   #:bg              (custom-background)
   #:avatar          (custom-avatar #:sprite      (row->sprite (random-character-row))
                                    #:key-mode    'wasd       ;OPTIONAL
                                    #:mouse-aim?  #t          ;OPTIONAL
                                    )
   #:weapon-list     (list (custom-weapon #:name              "Spear"
                                          #:sprite            SPEAR-ICON
                                          #:mouse-fire-button 'left        ;OPTIONAL
                                          #:dart              (my-spear)
                                          #:rapid-fire?       #f           ;OPTIONAL
                                          #:rarity            'rare        ;OPTIONAL
                                          )
                           (custom-weapon #:name              "Sword"
                                          #:sprite            SWORD-ICON
                                          #:mouse-fire-button 'left        ;OPTIONAL
                                          #:dart              (my-sword)
                                          #:rapid-fire?       #f           ;OPTIONAL
                                          #:rarity            'rare        ;OPTIONAL
                                          )
                           (custom-weapon #:name              "Paint Thrower"
                                          #:sprite             PAINT-THROWER-ICON
                                          #:dart              (my-paint)
                                          #:mouse-fire-button 'left        ;OPTIONAL
                                          #:fire-mode         'random
                                          #:fire-rate          30
                                          #:rarity            'epic        ;OPTIONAL
                                          )
                           (custom-weapon #:name              "Flying Dagger Spell"
                                          #:sprite             FLYING-DAGGER-ICON
                                          #:dart              (my-flying-dagger)
                                          #:mouse-fire-button 'left        ;OPTIONAL
                                          #:fire-mode         'spread
                                          #:fire-rate          1
                                          #:rarity            'legendary   ;OPTIONAL
                                          )
                           (custom-weapon #:name              "Ring of Fire Spell"
                                          #:sprite             RING-OF-FIRE-ICON
                                          #:dart              (my-ring-of-fire)
                                          #:mouse-fire-button 'left        ;OPTIONAL
                                          #:fire-rate          30
                                          #:rarity            'legendary   ;OPTIONAL
                                          )))
  )



(define-example-code battle-arena fortnite-melee-battle-simple
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name        "Spear"
                                      #:sprite      SPEAR-ICON
                                      #:dart        (spear)
                                      #:rapid-fire? #f)
                       (custom-weapon #:name        "Sword"
                                      #:sprite      SWORD-ICON
                                      #:dart        (sword #:damage     20
                                                           #:durability 50))
                       (custom-weapon #:name        "Paint Thrower"
                                      #:sprite      PAINT-THROWER-ICON
                                      #:dart        (paint #:damage     10
                                                           #:durability 20
                                                           #:range      20)
                                      #:fire-mode   'random
                                      #:fire-rate   30)
                       (custom-weapon #:name        "Flying Dagger Spell"
                                      #:sprite      FLYING-DAGGER-ICON
                                      #:dart        (flying-dagger)
                                      #:fire-mode   'spread
                                      #:fire-rate    1)
                       (custom-weapon #:name        "Ring of Fire Spell"
                                      #:sprite      RING-OF-FIRE-ICON
                                      #:dart        (ring-of-fire)
                                      #:fire-rate   30))))




(define-example-code battle-arena fortnite-melee-battle
  ; ======= FORTNITE MELEE =======
  (define (my-sword-bullet)
    (custom-dart #:position (posn 10 0)
                 #:sprite sword-bullet-sprite
                 #:damage 50
                 #:durability 20
                 #:speed  0
                 #:range  10
                 #:components (every-tick (change-direction-by 15))))

  (define (my-paint-bullet)
    (custom-dart #:position (posn 25 0)
                 #:sprite paint-sprite
                 #:damage 5
                 #:durability 5
                 #:speed  3
                 #:range  15
                 #:components (on-start (set-size 0.5))
                 (every-tick (scale-sprite 1.1))))

  (battle-arena-game
   #:bg              (custom-background)
   #:avatar          (custom-avatar #:sprite      (row->sprite (random-character-row))
                                    #:key-mode    'wasd
                                    #:mouse-aim?  #t)
   #:weapon-list     (list (custom-weapon #:sprite SWORD-ICON
                                          #:dart (sword)
                                          #:rapid-fire? #f
                                          #:rarity 'common)
                           (custom-weapon #:sprite PAINT-THROWER-ICON
                                          #:dart (paint)
                                          #:fire-rate 30
                                          #:rarity 'legendary)
                           (custom-weapon #:sprite SPEAR-ICON
                                          #:dart (spear)
                                          #:rapid-fire? #f
                                          #:rarity 'uncommon))))



(define-example-code battle-arena grow-1
  
  (battle-arena-game
   #:item-list (list (custom-item #:name   "Grow Potion"
                                  #:sprite (make-icon "BIG" 'red 'white)
                                  #:on-use (scale-sprite 2 #:for 100)))))



(define-example-code battle-arena grow-and-shrink

  (define (grow-potion)
    (custom-item #:name   "Grow Potion"
                 #:sprite (make-icon "BIG" 'red 'white)
                 #:on-use (scale-sprite 2 #:for 100)
                 #:rarity 'common))

  (define (shrink-potion)
    (custom-item #:name     "Shrink Potion"
                 #:sprite   (make-icon "SML" 'blue 'white)
                 #:on-use   (scale-sprite 0.5 #:for 100)
                 #:rarity   'rare))
  
  (battle-arena-game
   #:item-list      (list (grow-potion)
                          (shrink-potion))))



(define-example-code battle-arena health-1
  
  (battle-arena-game
   #:item-list (list (custom-item #:name   "Health Potion"
                                  #:sprite (make-icon "HP" 'green 'white)
                                  #:on-use (change-health-by 50)))))



(define-example-code battle-arena health-2
  
  (battle-arena-game
   #:item-list (list (custom-item #:name   "Max Health Potion"
                                  #:sprite (make-icon "MHP" 'green 'white)
                                  #:on-use (set-health-to 100)))))



(define-example-code battle-arena health-3

  (define (health-potion)
    (custom-item #:name     "Health Potion"
                 #:sprite   (make-icon "HP" 'green 'white)
                 #:on-use   (change-health-by 50)
                 #:rarity   'uncommon
                 #:respawn? #t))
  
  (define (max-health-potion)
    (custom-item #:name   "Max Health Potion"
                 #:sprite (make-icon "MHP" 'green 'white)
                 #:on-use (set-health-to 100)
                 #:rarity 'epic))
  
  (battle-arena-game
   #:item-list      (list (health-potion)
                          (max-health-potion))))



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



(define-example-code battle-arena lava-1
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Lava Pit"
                        #:sprite (make-icon "LP")
                        #:dart (lava-builder)))))



(define-example-code battle-arena lava-2
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Lava Pit"
                        #:sprite (make-icon "LP" 'red)
                        #:dart (lava-builder
                                #:damage 25
                                #:size   2)))))



(define-example-code battle-arena lava-3
  (battle-arena-game
   #:weapon-list (list (custom-weapon
                        #:name "Lava Pit"
                        #:sprite (make-icon "LP" 'red 'white)
                        #:dart (lava-builder
                                #:damage  25
                                #:size    1
                                #:sprite  (square 10 'solid 'black)
                                #:range   10)))))



(define-example-code battle-arena magic-balance-1
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name "Light Magic"
                                      #:sprite (make-icon "LM")
                                      #:dart (ring-of-fire #:damage 20
                                                           #:range   20)
                                      #:rarity 'common))))


(define-example-code battle-arena magic-balance-2
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name "Heavy Magic"
                                      #:sprite (make-icon "HM")
                                      #:dart (ring-of-fire #:sprite (scale 2 flame-sprite)
                                                           #:damage 200
                                                           #:range 36)
                                      #:rarity 'epic))))

(define-example-code battle-arena magic-balance-3
  (define (heavy-dart)
    (ring-of-fire #:sprite (scale 2 flame-sprite)
                  #:damage 200
                  #:range  36))

  (define (light-dart)
    (ring-of-fire #:damage 20
                  #:range  20))
  
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name "Heavy Magic"
                                      #:sprite (make-icon "HM")
                                      #:dart (heavy-dart)
                                      #:rarity 'epic)
                       (custom-weapon #:name "Light Magic"
                                      #:sprite (make-icon "LM")
                                      #:dart (light-dart)
                                      #:rarity 'common))))


(define-example-code battle-arena melee-balance-1
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name "Light Melee"
                                      #:sprite (make-icon "LM")
                                      #:dart (sword #:damage 50
                                                    #:speed  1)
                                      #:rarity 'common))))

(define-example-code battle-arena melee-balance-2
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name "Heavy Melee"
                                      #:sprite (make-icon "HM")
                                      #:dart (sword #:sprite (scale 2 swinging-sword-sprite)
                                                    #:damage 500
                                                    #:speed  2)
                                      #:rarity 'epic))))

(define-example-code battle-arena melee-balance-3
  (define (heavy-dart)
    (sword #:sprite (scale 2 swinging-sword-sprite)
           #:damage 500
           #:speed  2))

  (define (light-dart)
    (sword #:damage 50
           #:speed  1))
  
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name "Heavy Melee"
                                      #:sprite (make-icon "HM")
                                      #:dart (heavy-dart)
                                      #:rarity 'epic)
                       (custom-weapon #:name "Light Melee"
                                      #:sprite (make-icon "LM")
                                      #:dart (light-dart)
                                      #:rarity 'common))))


(define-example-code battle-arena offensive-base
  (battle-arena-game
   #:avatar         (custom-avatar #:sprite (random-character-sprite)
                                   #:item-slots 3)
   #:enemy-list     (list (custom-enemy #:ai 'easy
                                        #:amount-in-world 10)
                          (custom-enemy #:ai 'hard
                                        #:amount-in-world 10))
   #:weapon-list    (list (custom-weapon #:name "Rocket Tower"
                                         #:sprite (make-icon "RKT")
                                         #:dart (rocket-tower-builder
                                                 #:fire-mode 'homing
                                                 #:fire-rate 1
                                                 #:damage 100
                                                 #:speed 3
                                                 #:range 200))
                          (custom-weapon #:name "Repeater Tower"
                                         #:sprite (make-icon "RPT")
                                         #:dart (repeater-tower-builder
                                                 #:fire-mode 'random   ;'random = sloppy aim, not random fire mode
                                                 #:fire-rate 8
                                                 #:damage 5
                                                 #:speed 15
                                                 #:range 500))
                          (custom-weapon #:name "Dagger Tower"
                                         #:sprite (make-icon "DGT")
                                         #:dart (dagger-tower-builder
                                                 #:fire-mode 'spread
                                                 #:fire-rate 0.5
                                                 #:damage 200
                                                 #:speed 8
                                                 #:range 500))
                          )))











(define-example-code battle-arena paint-thrower-1
  
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name   "Paint Thrower"
                                      #:sprite PAINT-THROWER-ICON
                                      #:dart   (paint))))
  )




(define-example-code battle-arena paint-thrower-2-bonus
  (define (my-weapon-3)
    (custom-weapon #:name              "Paint Thrower"
                   #:sprite            PAINT-THROWER-ICON
                   #:dart              (paint)
                   #:rarity            'epic
                   #:fire-rate         30
                   #:mouse-fire-button 'left))
  
  (battle-arena-game
   #:weapon-list (list (my-weapon-3)))
  )




(define-example-code battle-arena paint-thrower-2
  (define (my-weapon-3)
    (custom-weapon #:name   "Paint Thrower"
                   #:sprite PAINT-THROWER-ICON
                   #:dart   (paint)
                   #:rarity 'epic))
  
  (battle-arena-game
   #:weapon-list (list (my-weapon-3)))
  )




(define-example-code battle-arena paint-thrower-3-bonus
  (define (my-paint)
    (paint #:damage     10
           #:durability 20
           #:sprite     paint-sprite
           #:speed      3
           #:range      15))
  
  (define (my-weapon-3)
    (custom-weapon #:name   "Paint Thrower"
                   #:sprite STUDENT-IMAGE-HERE
                   #:dart   (my-paint)
                   #:rarity 'epic))
  
  (battle-arena-game
   #:weapon-list (list (my-weapon-3)))
  )




(define-example-code battle-arena paint-thrower-3
  (define (my-paint)
    (paint #:damage     10
           #:durability 20))
  
  (define (my-weapon-3)
    (custom-weapon #:name   "Paint Thrower"
                   #:sprite STUDENT-IMAGE-HERE
                   #:dart   (my-paint)
                   #:rarity 'epic))
  
  (battle-arena-game
   #:weapon-list (list (my-weapon-3)))
  )




(define-example-code battle-arena paint-thrower-4
  (define (my-paint)
    (paint #:damage     10
           #:durability 20
           #:sprite     paint-sprite
           #:speed      3
           #:range      15))
  
  (define (my-weapon-3)
    (custom-weapon #:name   "Paint Thrower"
                   #:sprite STUDENT-IMAGE-HERE
                   #:dart   (my-paint)
                   #:rarity 'epic))
  
  (battle-arena-game
   #:weapon-list (list (my-weapon-3)))
  )



(define-example-code battle-arena ranged-battle-mode
  (battle-arena-game
   #:avatar         (custom-avatar #:sprite (random-character-sprite)
                                   #:item-slots 3)
   #:enemy-list     (list (custom-enemy #:ai 'easy
                                        #:amount-in-world 10)
                          (custom-enemy #:ai 'medium
                                        #:amount-in-world 10))
   #:weapon-list    (list (custom-weapon #:name "Single Shot"
                                         #:sprite (make-icon "SS")
                                         #:rapid-fire? #f         ;click as fast as you can to shoot
                                         #:dart (custom-dart
                                                 #:sprite (rectangle 10 2 'solid 'cyan)
                                                 #:damage 10
                                                 #:speed 10
                                                 #:range 50)
                                          #:rarity 'common)
                          (custom-weapon #:name "Spread Shot"
                                         #:sprite (make-icon "SPR")
                                         #:fire-mode 'spread      ;options 'normal, 'random, 'homing, 'spread
                                         #:fire-rate 2
                                         #:dart (custom-dart
                                                 #:sprite (rectangle 10 2 'solid 'orange)
                                                 #:damage 20
                                                 #:durability 20   ;will die after hitting second enemy
                                                 #:speed 15
                                                 #:range 15)
                                         #:rarity 'rare)
                          (custom-weapon #:name "Homing Repeater"
                                         #:sprite (make-icon "HR")
                                         #:fire-mode 'homing
                                         #:fire-rate 5
                                         #:dart (custom-dart
                                                 #:sprite (rectangle 10 2 'solid 'pink)
                                                 #:damage 15
                                                 #:speed 8
                                                 #:range 40)
                                          #:rarity 'epic)
                          )))




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
   #:item-list (list (custom-item #:name     "Shield Potion" 
                                  #:sprite   (make-icon "SP" 'blue 'white)
                                  #:on-use   (change-shield-by 50))))
  )





(define-example-code battle-arena shield-2
  (battle-arena-game
   #:item-list (list (custom-item #:name     "Max Shield Potion"
                                  #:sprite   (make-icon "MSP" 'blue 'white)
                                  #:on-use   (set-shield-to 100))))
  )





(define-example-code battle-arena shield-3

  (define (shield-potion)
    (custom-item #:name     "Shield Potion" 
                 #:sprite   (make-icon "SP" 'blue 'white)
                 #:on-use   (change-shield-by 50)
                 #:rarity   'uncommon
                 #:respawn? #t))

  (define (max-shield)
    (custom-item #:name     "Max Shield Potion"
                 #:sprite   (make-icon "MSP" 'blue 'white)
                 #:on-use   (set-shield-to 100)
                 #:rarity   'epic))
  
  (battle-arena-game
   #:item-list (list (shield-potion)
                     (max-shield)))
  )




(define-example-code battle-arena shrink-1

  (battle-arena-game
   #:item-list (list (custom-item #:name   "Shrink Potion"
                                  #:sprite (make-icon "SML" 'blue 'white)
                                  #:on-use (scale-sprite 0.5 #:for 100)))))



(define-example-code battle-arena single-shot-1
  (battle-arena-game
   #:weapon-list    (list (custom-weapon #:name      "Single Shot"
                                         #:sprite    (make-icon "SS")
                                         #:fire-mode 'normal))))



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



(define-example-code battle-arena spear-1
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name   "Spear"
                                      #:sprite SPEAR-ICON
                                      #:dart   (spear))))
  )



(define-example-code battle-arena spear-2-bonus
  (define (my-weapon-1)
    (custom-weapon #:name              "Spear"
                   #:sprite            SPEAR-ICON
                   #:dart              (spear)
                   #:rarity            'common
                   #:mouse-fire-button 'left
                   #:rapid-fire?       #f))
  
  (battle-arena-game
   #:weapon-list (list (my-weapon-1)))
  )



(define-example-code battle-arena spear-2
  (define (my-weapon-1)
    (custom-weapon #:name   "Spear"
                   #:sprite SPEAR-ICON
                   #:dart   (spear)
                   #:rarity 'common))
  
  (battle-arena-game
   #:weapon-list (list (my-weapon-1)))
  )



(define-example-code battle-arena spear-3-bonus
  (define (my-spear)
    (spear #:damage     25
           #:durability 10
           #:sprite     spear-sprite
           #:speed      5
           #:range      20))
  
  (define (my-weapon-1)
    (custom-weapon #:name   "Spear"
                   #:sprite STUDENT-IMAGE-HERE
                   #:dart   (my-spear)
                   #:rarity 'common))
  
  (battle-arena-game
   #:weapon-list (list (my-weapon-1)))
  )



(define-example-code battle-arena spear-3
  (define (my-spear)
    (spear #:damage     25
           #:durability 10))
  
  (define (my-weapon-1)
    (custom-weapon #:name   "Spear"
                   #:sprite STUDENT-IMAGE-HERE
                   #:dart   (my-spear)
                   #:rarity 'common))
  
  (battle-arena-game
   #:weapon-list (list (my-weapon-1))))



(define-example-code battle-arena spear-4
  (define (my-spear)
    (spear #:damage     25
           #:durability 10
           #:sprite     spear-sprite
           #:speed      5
           #:range      20))
  
  (define (my-weapon-1)
    (custom-weapon #:name   "Spear"
                   #:sprite STUDENT-IMAGE-HERE
                   #:dart   (my-spear)
                   #:rarity 'common))
  
  (battle-arena-game
   #:weapon-list (list (my-weapon-1)))
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



(define-example-code battle-arena spear-tower-builder-1
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



(define-example-code battle-arena spike-mine-builder-1
  (battle-arena-game
   #:enemy-list  (list (custom-enemy #:amount-in-world 10))
   #:weapon-list (list (custom-weapon
                        #:dart (spike-mine-builder)))))





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




(define-example-code battle-arena sword-1
  
  (battle-arena-game
   #:weapon-list (list (custom-weapon #:name    "Sword"
                                      #:sprite  SWORD-ICON
                                      #:dart    (sword)))))




(define-example-code battle-arena sword-2
  (define (my-weapon-2)
    (custom-weapon #:name    "Sword"
                   #:sprite  SWORD-ICON
                   #:dart    (sword)
                   #:rarity  'rare))
  
  (battle-arena-game
   #:weapon-list (list (my-weapon-2))))




(define-example-code battle-arena sword-2b
  (define (my-weapon-2)
    (custom-weapon #:name              "Sword"
                   #:sprite            SWORD-ICON
                   #:dart              (sword)
                   #:rarity            'rare
                   #:mouse-fire-button 'left
                   #:rapid-fire?        #f))
  
  (battle-arena-game
   #:weapon-list (list (my-weapon-2))))





(define-example-code battle-arena sword-3

  (define (my-sword)
    (sword #:damage     50
           #:durability 20))
  
  (define (my-weapon-2)
    (custom-weapon #:name   "Sword"
                   #:sprite STUDENT-IMAGE-HERE
                   #:dart   (my-sword)))
  
  (battle-arena-game
   #:weapon-list (list (my-weapon-2))))





(define-example-code battle-arena sword-3b

  (define (my-sword)
    (sword #:damage     50
           #:durability 20
           #:sprite     STUDENT-IMAGE-HERE
           #:speed      0
           #:range      10))
  
  (define (my-weapon-2)
    (custom-weapon #:name   "Sword"
                   #:sprite STUDENT-IMAGE-HERE
                   #:dart   (my-sword)))
  
  (battle-arena-game
   #:weapon-list (list (my-weapon-2))))





(define-example-code battle-arena sword-4

  (define (my-sword)
    (sword #:damage     50
           #:durability 20
           #:sprite     STUDENT-IMAGE-HERE
           #:speed      0
           #:range      10))
  
  (define (my-weapon-2)
    (custom-weapon #:name   "Sword"
                   #:sprite STUDENT-IMAGE-HERE
                   #:dart   (my-sword)))
  
  (battle-arena-game
   #:weapon-list (list (my-weapon-2))))




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
                                    #:weapon          (custom-weapon
                                                       #:name "Sword"
                                                       #:dart (sword))))
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





#lang racket

(require ts-kata-util
         "./lang/main.rkt"
         battle-arena-starwars)


;(define-example-code/from* battle-arena/examples) making my own examples here

;If you want to hook into any of the exported
;  syntax:kata-names, this would be the file to do that.
;You can't see them, but they are here, defined by
;  define-example-code/from*

(define-example-code battle-arena-starwars hero-1
 (starwars-game
   #:hero (custom-hero))
  )

(define-example-code battle-arena-starwars hero-2
 (starwars-game
   #:hero (custom-hero #:sprite (star 20 'solid 'yellow)))
  )

(define-example-code battle-arena-starwars hero-3
 (starwars-game
   #:hero (custom-hero #:sprite yoda-sprite))
  )

(define-example-code battle-arena-starwars hero-4
  (define (my-hero)
    (custom-hero #:sprite     yoda-sprite
                 #:speed      15
                 #:key-mode   'arrow-keys
                 #:item-slots 5))
  (starwars-game
   #:hero (my-hero))
  )

; ---------------

(define-example-code battle-arena-starwars enemy-1
 (starwars-game
   #:villain-list (list (custom-villain)))
  )

(define-example-code battle-arena-starwars enemy-2
  (define (my-enemy)
    (custom-villain #:ai              'easy
                    #:health          200
                    #:shield          100
                    #:amount-in-world 5))

  (starwars-game 
   #:villain-list (list (my-enemy)))
  )

(define-example-code battle-arena-starwars enemy-3
  (define (my-enemy)
    (custom-villain #:sprite          darthvader-sprite
                    #:ai              'medium
                    #:health          200
                    #:shield          100
                    #:amount-in-world 5))
  
  (starwars-game 
   #:villain-list (list (my-enemy)))
  )

; ---------------

(define-example-code battle-arena-starwars enemy-weapon-1
  (starwars-game 
   #:villain-list (list (custom-villain
                       #:weapon (custom-blaster
                                 #:color "yellow"))))
  )

(define-example-code battle-arena-starwars enemy-weapon-2
  (starwars-game 
   #:villain-list (list (custom-villain
                       #:sprite darthvader-sprite
                       #:weapon (custom-lightsaber
                                 #:color "red"))))
  )

(define-example-code battle-arena-starwars enemy-weapon-3 
  (define (my-weapon)
    (custom-lightsaber 
     #:dart (double-lightsaber)))
 
  (starwars-game 
   #:villain-list (list (custom-villain
                       #:sprite darthmaul-sprite
                       #:weapon (my-weapon))))
  )

; ---------------

(define-example-code battle-arena-starwars lightsaber-1
  (starwars-game
   #:weapon-list (list (custom-lightsaber)))
  )

(define-example-code battle-arena-starwars lightsaber-2
  (define (my-lightsaber)
    (custom-lightsaber #:name   "Flashy"
                       #:icon   (make-icon "F" "blue")
                       #:rarity 'rare))
  
  (starwars-game
   #:weapon-list (list (my-lightsaber)))
  )


(define-example-code battle-arena-starwars lightsaber-3
  (define (my-blade)
    (lightsaber #:color      "blue"
                #:damage     25
                #:durability 30))
    
  (define (my-lightsaber)
    (custom-lightsaber #:name   "Flashy"
                       #:icon   (make-icon "F" "blue")
                       #:rarity 'rare
                       #:dart   (my-blade)))
  
  (starwars-game
   #:weapon-list (list (my-lightsaber)))
  )

; ---------------

(define-example-code battle-arena-starwars blaster-1
  (starwars-game
   #:weapon-list (list (custom-blaster)))
  )

(define-example-code battle-arena-starwars blaster-2
  (define (my-blaster)
    (custom-blaster
     #:name   "Blasty"
     #:icon   (make-icon "B" "orange")
     #:rarity 'legendary))
  
  (starwars-game
   #:weapon-list (list (my-blaster)))
  )


(define-example-code battle-arena-starwars blaster-3
  (define (my-dart)
    (blaster-dart #:color      "orange"
                  #:damage     20
                  #:durability 25
                  #:speed      10
                  #:range      70))
  
  (define (my-blaster)
    (custom-blaster  #:dart   (my-dart)
                     #:name   "Blasty"
                     #:rarity 'legendary
                     #:icon   (make-icon "B" "orange")))

  (starwars-game
   #:weapon-list (list (my-blaster)))
  )

; ---------------

(define-example-code battle-arena-starwars planet-1
  (starwars-game
   #:planet (custom-planet))
  )

(define-example-code battle-arena-starwars planet-2
  (starwars-game
   #:planet (custom-planet #:img LAVA-BG))
  )


(define-example-code battle-arena-starwars planet-3
  (define (my-planet)
    (custom-planet #:img        LAVA-BG
                   #:rows       2
                   #:columns    2
                   #:start-tile 4))
  
  (starwars-game
   #:planet (my-planet))
)

; ---------------

(define-example-code battle-arena-starwars heal-1
  (starwars-game
   #:item-list (list (custom-item #:name   "Force Heal"
                                  #:sprite (make-icon "HP" 'green 'white) 
                                  #:on-use (change-health-by 50))))
  )

(define-example-code battle-arena-starwars heal-2
  (starwars-game
   #:item-list (list (custom-item #:name   "Force Max Heal" 
                                  #:sprite (make-icon "xHP" 'green 'white) 
                                  #:on-use (set-health-to 100))))
  )

(define-example-code battle-arena-starwars heal-3
  (define (force-heal)
    (custom-item #:name     "Force Heal" 
                 #:sprite   (make-icon "HP" 'green 'white) 
                 #:on-use   (change-health-by 50) 
                 #:rarity   'uncommon 
                 #:respawn? #t))
 
  (define (force-max-heal)
    (custom-item #:name   "Force Max Heal" 
                 #:sprite (make-icon "xHP" 'green 'white) 
                 #:on-use (set-health-to 100) 
                 #:rarity 'epic))
 
  (starwars-game
   #:item-list (list (force-heal)
                     (force-max-heal)))
  )

; -----------------

(define-example-code battle-arena-starwars boost-1
  (starwars-game
    #:item-list (list (custom-item #:name "Force Damage" 
                                   #:sprite (make-icon "FD" 'orangered) 
                                   #:on-use (change-damage-by 1000 #:for 200))))

  )

(define-example-code battle-arena-starwars boost-2
  (starwars-game
    #:item-list (list (custom-item #:name "Force Speed" 
                                   #:sprite (make-icon "FS" 'yellow) 
                                   #:on-use (multiply-speed-by 2 #:for 200))))
  )

(define-example-code battle-arena-starwars boost-3
   (define (force-damage)
     (custom-item #:name "Force Damage" 
                  #:sprite (make-icon "FD" 'orangered) 
                  #:on-use (change-damage-by 1000 #:for 200) 
                  #:rarity 'epic))
 
   (define (force-speed)
     (custom-item #:name "Force Speed" 
                  #:sprite (make-icon "FS" 'yellow) 
                  #:on-use (multiply-speed-by 2 #:for 200) 
                  #:rarity 'uncommon))
 
  (starwars-game
    #:item-list (list (force-damage)
                      (force-speed)))
  )

; -----------------

(define-example-code battle-arena-starwars shield-1
  (starwars-game
   #:item-list (list (custom-item #:name    "Shield" 
                                  #:sprite  (make-icon "S" 'blue 'white)
                                  #:on-use  (change-shield-by 50))))
  )

(define-example-code battle-arena-starwars shield-2
  (starwars-game
    #:item-list (list (custom-item #:name  "Max Shield"
                                  #:sprite (make-icon "xS" 'blue 'white)
                                  #:on-use (set-shield-to 100))))
  )

(define-example-code battle-arena-starwars shield-3
  (define (shield-bump)
    (custom-item #:name     "Shield" 
                 #:sprite   (make-icon "S" 'blue 'white)
                 #:on-use   (change-shield-by 50)
                 #:rarity   'uncommon
                 #:respawn? #t))

  (define (max-shield)
    (custom-item #:name     "Max Shield"
                 #:sprite   (make-icon "xS" 'blue 'white)
                 #:on-use   (set-shield-to 100)
                 #:rarity   'epic))
  
  (starwars-game
   #:item-list (list (shield-bump)
                     (max-shield)))
  )

; -----------------

(define-example-code battle-arena-starwars force-field-1
  (starwars-game
   #:item-list (list (custom-item #:name "Force Field"
                                  #:on-use (spawn (force-field)))))
  )

(define-example-code battle-arena-starwars force-field-2
  (starwars-game
   #:item-list (list (custom-item #:name "Force Field"
                                  #:sprite (make-icon "FF")
                                  #:on-use (spawn (force-field #:duration 1000)))))
  )

(define-example-code battle-arena-starwars force-field-3
  (define (force-field-item)
    (custom-item #:name "Force Field"
                 #:sprite (make-icon "FF")
                 #:on-use (spawn (force-field #:allow-friendly-dart? #t
                                              #:duration 1000))))
 
  (starwars-game
    #:item-list (list (force-field-item)))
  )

;---------------------

(define-example-code battle-arena-starwars lightsaber-droid-1
  (starwars-game
   #:weapon-list (list (custom-weapon 
                        #:name   "Lightsaber Droid" 
                        #:sprite (make-icon "LD")
                        #:dart   (lightsaber-droid))))
  )

(define-example-code battle-arena-starwars lightsaber-droid-2
  (define (ls-droid)
    (custom-weapon 
     #:name   "Lightsaber Droid" 
     #:sprite (make-icon "LS")
     #:rarity 'epic
     #:dart   (lightsaber-droid #:color      "orange"
                                #:damage     25 
                                #:durability 30)))

  (starwars-game
   #:weapon-list (list (ls-droid)))
  )

(define-example-code battle-arena-starwars lightsaber-droid-3
  (define (ls-droid)
    (custom-weapon 
     #:name   "Lightsaber Droid" 
     #:sprite (make-icon "LS")
     #:rarity 'epic
     #:dart   (lightsaber-droid #:color      "orange"
                                #:damage     25 
                                #:speed      10
                                #:durability 30
                                #:range      20
                                #:fire-rate  0.5)))

  (starwars-game
   #:weapon-list (list (ls-droid)))
  )

;---------------------

(define-example-code battle-arena-starwars blaster-droid-1
  (starwars-game
   #:weapon-list (list (custom-weapon 
                        #:name   "Blaster Droid" 
                        #:sprite (make-icon "BD")
                        #:dart   (blaster-droid))))
  )

(define-example-code battle-arena-starwars blaster-droid-2
  (define (b-droid)
    (custom-weapon 
     #:name   "Blaster Droid" 
     #:sprite (make-icon "BD")
     #:dart   (blaster-droid #:color     "yellow"
                             #:damage    25
                             #:fire-mode 'spread)))
  
  (starwars-game
   #:weapon-list (list (b-droid)))
  )

(define-example-code battle-arena-starwars blaster-droid-3
  (define (b-droid)
    (custom-weapon 
     #:name   "Blaster Droid" 
     #:sprite (make-icon "BD")
     #:dart   (blaster-droid #:color     "yellow"
                             #:damage     15
                             #:durability 25
                             #:speed      10
                             #:range      75
                             #:fire-rate  5
                             #:fire-mode  'homing)))
  
  (starwars-game
   #:weapon-list (list (b-droid)))
  )

; ----------
(define-example-code battle-arena-starwars lightsaber-armor-1  
  (starwars-game
   #:item-list (list (custom-armor #:name          "Lightsaber Armor"
                                   #:protects-from "Ligthsaber"
                                   #:sprite        (make-icon "LA"))))
  )

(define-example-code battle-arena-starwars lightsaber-armor-2
  (define (l-armor)
    (custom-armor #:name          "Lightsaber Armor"
                  #:protects-from "Ligthsaber"
                  #:sprite        (make-icon "LA")
                  #:change-damage (subtract-by 30)
                  #:rarity        'rare))
  
  (starwars-game
   #:item-list (list (l-armor)))  
  )

(define-example-code battle-arena-starwars lightsaber-armor-3
  (define (l-armor)
    (custom-armor #:name          "Lightsaber Armor"
                  #:protects-from "Ligthsaber"
                  #:sprite        (make-icon "LA")
                  #:change-damage (subtract-by 30)
                  #:rarity        'rare))
  
  (starwars-game
   #:villain-list (list (custom-villain #:sprite darthvader-sprite
                                        #:weapon (custom-lightsaber #:color "red")))
   #:item-list    (list (l-armor)))
  )

; ----------
(define-example-code battle-arena-starwars blaster-armor-1 
  (starwars-game
   #:item-list (list (custom-armor #:name          "Blaster Armor"
                                   #:protects-from "Blaster"
                                   #:sprite        (make-icon "BA"))))
  )

(define-example-code battle-arena-starwars blaster-armor-2
  (define (b-armor)
    (custom-armor #:name          "Blaster Armor"
                  #:protects-from "Blaster"
                  #:sprite        (make-icon "BA")
                  #:change-damage (subtract-by 30)
                  #:rarity        'rare))
  
  (starwars-game
   #:item-list (list (b-armor)))  
  )

(define-example-code battle-arena-starwars blaster-armor-3
  (define (b-armor)
    (custom-armor #:name          "Blaster Armor"
                  #:protects-from "Blaster"
                  #:sprite        (make-icon "BA")
                  #:change-damage (subtract-by 30)
                  #:rarity        'rare))
  
  (starwars-game
   #:villain-list (list (custom-villain))
   #:item-list    (list (b-armor)))
  )

;We'll test that the examples all run as games for 10 ticks
(test-all-examples-as-games 'battle-arena-starwars)

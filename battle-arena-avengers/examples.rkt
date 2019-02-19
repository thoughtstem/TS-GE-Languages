#lang racket

(require ts-kata-util
         "./lang/main.rkt" ;this was not added automatically
         battle-arena-avengers)

;this was not added automatically
;(define-example-code/from* battle-arena/examples) making my own examples here


;And you probably want your lang, not racket below.
;  But technically you can make examples for any language
;(define-example-code racket my-example-1
;  (require 2htdp/image)
;
;  (circle 40 'solid 'red))
;
;You can define as many examples as you want in this file



;-------------- copied from battle-arena-avengers/examples.rkt

;If you want to hook into any of the exported
;  syntax:kata-names, this would be the file to do that.
;You can't see them, but they are here, defined by
;  define-example-code/from*

(define-example-code battle-arena-avengers hero-1
 (avengers-game
   #:hero (custom-hero))
  )

(define-example-code battle-arena-avengers hero-2
 (avengers-game
   #:hero (custom-hero #:sprite (star 20 'solid 'yellow)))
  )

(define-example-code battle-arena-avengers hero-3
 (avengers-game
   #:hero (custom-hero #:sprite yoda-sprite))
  )

(define-example-code battle-arena-avengers hero-4
  (define (my-hero)
    (custom-hero #:sprite     yoda-sprite
                 #:speed      15
                 #:key-mode   'arrow-keys
                 #:item-slots 5))
  (avengers-game
   #:hero (my-hero))
  )

; ---------------

(define-example-code battle-arena-avengers enemy-1
 (avengers-game
   #:villain-list (list (custom-villain)))
  )

(define-example-code battle-arena-avengers enemy-2
  (define (my-enemy)
    (custom-villain #:ai              'easy
                    #:health          200
                    #:shield          100
                    #:amount-in-world 5))

  (avengers-game 
   #:villain-list (list (my-enemy)))
  )

(define-example-code battle-arena-avengers enemy-3
  (define (my-enemy)
    (custom-villain #:sprite          darthvader-sprite
                    #:ai              'medium
                    #:health          200
                    #:shield          100
                    #:amount-in-world 5))
  
  (avengers-game 
   #:villain-list (list (my-enemy)))
  )

; ---------------

(define-example-code battle-arena-avengers enemy-weapon-1
  (avengers-game 
   #:villain-list (list (custom-villain
                       #:weapon (custom-blaster
                                 #:color "yellow"))))
  )

(define-example-code battle-arena-avengers enemy-weapon-2
  (avengers-game 
   #:villain-list (list (custom-villain
                       #:sprite darthvader-sprite
                       #:weapon (custom-lightsaber
                                 #:color "red"))))
  )

(define-example-code battle-arena-avengers enemy-weapon-3 
  (define (my-weapon)
    (custom-lightsaber 
     #:dart (double-lightsaber)))
 
  (avengers-game 
   #:villain-list (list (custom-villain
                       #:sprite darthmaul-sprite
                       #:weapon (my-weapon))))
  )

; ---------------

(define-example-code battle-arena-avengers lightsaber-1
  (avengers-game
   #:weapon-list (list (custom-lightsaber)))
  )

(define-example-code battle-arena-avengers lightsaber-2
  (define (my-lightsaber)
    (custom-lightsaber #:name   "Flashy"
                       #:icon   (make-icon "F" "blue")
                       #:rarity 'rare))
  
  (avengers-game
   #:weapon-list (list (my-lightsaber)))
  )


(define-example-code battle-arena-avengers lightsaber-3
  (define (my-blade)
    (lightsaber #:color      "blue"
                #:damage     25
                #:durability 30))
    
  (define (my-lightsaber)
    (custom-lightsaber #:name   "Flashy"
                       #:icon   (make-icon "F" "blue")
                       #:rarity 'rare
                       #:dart   (my-blade)))
  
  (avengers-game
   #:weapon-list (list (my-lightsaber)))
  )

; ---------------

(define-example-code battle-arena-avengers blaster-1
  (avengers-game
   #:weapon-list (list (custom-blaster)))
  )

(define-example-code battle-arena-avengers blaster-2
  (define (my-blaster)
    (custom-blaster
     #:name   "Blasty"
     #:icon   (make-icon "B" "orange")
     #:rarity 'legendary))
  
  (avengers-game
   #:weapon-list (list (my-blaster)))
  )


(define-example-code battle-arena-avengers blaster-3
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

  (avengers-game
   #:weapon-list (list (my-blaster)))
  )

; ---------------

(define-example-code battle-arena-avengers planet-1
  (avengers-game
   #:planet (custom-planet))
  )

(define-example-code battle-arena-avengers planet-2
  (avengers-game
   #:planet (custom-planet #:img LAVA-BG))
  )


(define-example-code battle-arena-avengers planet-3
  (define (my-planet)
    (custom-planet #:img        LAVA-BG
                   #:rows       2
                   #:columns    2
                   #:start-tile 4))
  
  (avengers-game
   #:planet (my-planet))
)

; ---------------

(define-example-code battle-arena-avengers heal-1
  (avengers-game
   #:item-list (list (custom-item #:name   "Force Heal"
                                  #:sprite (make-icon "HP" 'green 'white) 
                                  #:on-use (change-health-by 50))))
  )

(define-example-code battle-arena-avengers heal-2
  (avengers-game
   #:item-list (list (custom-item #:name   "Force Max Heal" 
                                  #:sprite (make-icon "xHP" 'green 'white) 
                                  #:on-use (set-health-to 100))))
  )

(define-example-code battle-arena-avengers heal-3
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
 
  (avengers-game
   #:item-list (list (force-heal)
                     (force-max-heal)))
  )

; -----------------

(define-example-code battle-arena-avengers boost-1
  (avengers-game
    #:item-list (list (custom-item #:name "Force Damage" 
                                   #:sprite (make-icon "FD" 'orangered) 
                                   #:on-use (change-damage-by 1000 #:for 200))))

  )

(define-example-code battle-arena-avengers boost-2
  (avengers-game
    #:item-list (list (custom-item #:name "Force Speed" 
                                   #:sprite (make-icon "FS" 'yellow) 
                                   #:on-use (multiply-speed-by 2 #:for 200))))
  )

(define-example-code battle-arena-avengers boost-3
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
 
  (avengers-game
    #:item-list (list (force-damage)
                      (force-speed)))
  )

; -----------------

(define-example-code battle-arena-avengers shield-1
  (avengers-game
   #:item-list (list (custom-item #:name    "Shield" 
                                  #:sprite  (make-icon "S" 'blue 'white)
                                  #:on-use  (change-shield-by 50))))
  )

(define-example-code battle-arena-avengers shield-2
  (avengers-game
    #:item-list (list (custom-item #:name  "Max Shield"
                                  #:sprite (make-icon "xS" 'blue 'white)
                                  #:on-use (set-shield-to 100))))
  )

(define-example-code battle-arena-avengers shield-3
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
  
  (avengers-game
   #:item-list (list (shield-bump)
                     (max-shield)))
  )

; -----------------

(define-example-code battle-arena-avengers force-field-1
  (avengers-game
   #:item-list (list (custom-item #:name "Force Field"
                                  #:on-use (spawn (force-field)))))
  )

(define-example-code battle-arena-avengers force-field-2
  (avengers-game
   #:item-list (list (custom-item #:name "Force Field"
                                  #:sprite (make-icon "FF")
                                  #:on-use (spawn (force-field #:duration 1000)))))
  )

(define-example-code battle-arena-avengers force-field-3
  (define (force-field-item)
    (custom-item #:name "Force Field"
                 #:sprite (make-icon "FF")
                 #:on-use (spawn (force-field #:allow-friendly-dart? #t
                                              #:duration 1000))))
 
  (avengers-game
    #:item-list (list (force-field-item)))
  )

;---------------------

(define-example-code battle-arena-avengers lightsaber-droid-1
  (avengers-game
   #:weapon-list (list (custom-weapon 
                        #:name   "Lightsaber Droid" 
                        #:sprite (make-icon "LD")
                        #:dart   (lightsaber-droid))))
  )

(define-example-code battle-arena-avengers lightsaber-droid-2
  (define (ls-droid)
    (custom-weapon 
     #:name   "Lightsaber Droid" 
     #:sprite (make-icon "LS")
     #:rarity 'epic
     #:dart   (lightsaber-droid #:color      "orange"
                                #:damage     25 
                                #:durability 30)))

  (avengers-game
   #:weapon-list (list (ls-droid)))
  )

(define-example-code battle-arena-avengers lightsaber-droid-3
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

  (avengers-game
   #:weapon-list (list (ls-droid)))
  )

;---------------------

(define-example-code battle-arena-avengers blaster-droid-1
  (avengers-game
   #:weapon-list (list (custom-weapon 
                        #:name   "Blaster Droid" 
                        #:sprite (make-icon "BD")
                        #:dart   (blaster-droid))))
  )

(define-example-code battle-arena-avengers blaster-droid-2
  (define (b-droid)
    (custom-weapon 
     #:name   "Blaster Droid" 
     #:sprite (make-icon "BD")
     #:dart   (blaster-droid #:color     "yellow"
                             #:damage    25
                             #:fire-mode 'spread)))
  
  (avengers-game
   #:weapon-list (list (b-droid)))
  )

(define-example-code battle-arena-avengers blaster-droid-3
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
  
  (avengers-game
   #:weapon-list (list (b-droid)))
  )

; ----------
(define-example-code battle-arena-avengers lightsaber-armor-1  
  (avengers-game
   #:item-list (list (custom-armor #:name          "Lightsaber Armor"
                                   #:protects-from "Ligthsaber"
                                   #:sprite        (make-icon "LA"))))
  )

(define-example-code battle-arena-avengers lightsaber-armor-2
  (define (l-armor)
    (custom-armor #:name          "Lightsaber Armor"
                  #:protects-from "Ligthsaber"
                  #:sprite        (make-icon "LA")
                  #:change-damage (subtract-by 30)
                  #:rarity        'rare))
  
  (avengers-game
   #:item-list (list (l-armor)))  
  )

(define-example-code battle-arena-avengers lightsaber-armor-3
  (define (l-armor)
    (custom-armor #:name          "Lightsaber Armor"
                  #:protects-from "Ligthsaber"
                  #:sprite        (make-icon "LA")
                  #:change-damage (subtract-by 30)
                  #:rarity        'rare))
  
  (avengers-game
   #:villain-list (list (custom-villain #:sprite darthvader-sprite
                                        #:weapon (custom-lightsaber #:color "red")))
   #:item-list    (list (l-armor)))
  )

; ----------
(define-example-code battle-arena-avengers blaster-armor-1 
  (avengers-game
   #:item-list (list (custom-armor #:name          "Blaster Armor"
                                   #:protects-from "Blaster"
                                   #:sprite        (make-icon "BA"))))
  )

(define-example-code battle-arena-avengers blaster-armor-2
  (define (b-armor)
    (custom-armor #:name          "Blaster Armor"
                  #:protects-from "Blaster"
                  #:sprite        (make-icon "BA")
                  #:change-damage (subtract-by 30)
                  #:rarity        'rare))
  
  (avengers-game
   #:item-list (list (b-armor)))  
  )

(define-example-code battle-arena-avengers blaster-armor-3
  (define (b-armor)
    (custom-armor #:name          "Blaster Armor"
                  #:protects-from "Blaster"
                  #:sprite        (make-icon "BA")
                  #:change-damage (subtract-by 30)
                  #:rarity        'rare))
  
  (avengers-game
   #:villain-list (list (custom-villain))
   #:item-list    (list (b-armor)))
  )

; ----------

(define-example-code battle-arena-avengers lava-pit-1
  (avengers-game
   #:weapon-list (list (custom-weapon #:name   "Lava Pit"
                                      #:sprite (make-icon "LP")
                                      #:dart   (lava-builder))))
  )

(define-example-code battle-arena-avengers lava-pit-2
  (define (my-lava-pit)
    (custom-weapon #:name   "Lava Pit"
                   #:sprite (make-icon "LP" 'red)
                   #:dart   (lava-builder #:damage 25
                                          #:size   2)))
  
  (avengers-game
   #:weapon-list (list (my-lava-pit)))
  )

(define-example-code battle-arena-avengers lava-pit-3
  (define (my-lava-pit)
    (custom-weapon #:name "Lava Pit"
                   #:sprite (make-icon "LP" 'red 'white)
                   #:dart (lava-builder #:damage  25
                                        #:size    1
                                        #:sprite  (square 10 'solid 'black)
                                        #:range   10)))
  
  (avengers-game
   #:weapon-list (list (my-lava-pit)))
  )

; ----------

(define-example-code battle-arena-avengers spike-mine-1
  (avengers-game
   #:weapon-list (list (custom-weapon #:name   "Spike Mine"
                                      #:sprite (make-icon "SM")
                                      #:dart   (spike-mine-builder))))
  )

(define-example-code battle-arena-avengers spike-mine-2
  (define (my-spike-mine)
    (custom-weapon #:name   "Spike Mine"
                   #:sprite (make-icon "SM" 'gray)
                   #:dart   (spike-mine-builder #:speed 10 
                                                #:range 50)))
  
  (avengers-game
   #:weapon-list (list (my-spike-mine)))
  )

(define-example-code battle-arena-avengers spike-mine-3
  (define (my-spike-mine)
    (custom-weapon #:name   "Spike Mine"
                   #:sprite (make-icon "SM" 'gray 'white)
                   #:dart   (spike-mine-builder #:sprite STUDENT-IMAGE-HERE
                                                #:damage 100
                                                #:speed 10
                                                #:range 50)))
  (avengers-game
   #:weapon-list (list (my-spike-mine)))
  )


;We'll test that the examples all run as games for 10 ticks
(test-all-examples-as-games 'battle-arena-avengers)

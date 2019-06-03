#lang racket

(require ts-kata-util
         "./lang/main.rkt"
         battlearena-starwars)


(define-example-code/from* battlearena/examples)

; ---------------

(define-example-code battlearena-starwars alt/avatar-2
 (starwars-game
   #:rebel (basic-rebel #:sprite yoda-sprite))
  )

(define-example-code battlearena-starwars alt/avatar-3
  (define (my-rebel)
    (basic-rebel #:sprite obiwan-sprite
                  #:speed  15))
  (starwars-game
   #:rebel (my-rebel))
  )

(define-example-code battlearena-starwars alt/avatar-4
  (define (my-rebel)
    (basic-rebel #:sprite     obiwan-sprite
                  #:speed      20
                  #:item-slots 5
                  #:health     200
                  #:max-health 200
                  #:shield     200
                  #:max-shield 200))
  (starwars-game
   #:rebel (my-rebel))
  )
; ---------------

(define-example-code battlearena-starwars alt/enemy-3
  (define (my-enemy)
    (basic-imperial #:sprite          darthmaul-sprite
                     #:ai              'medium
                     #:health          200
                     #:shield          100
                     #:amount-in-world 5))
  
  (starwars-game 
   #:imperial-list (list (my-enemy)))
  )

(define-example-code battlearena-starwars alt/enemy-4
  (define (easy-enemy)
    (basic-imperial #:ai 'easy
                     #:sprite stormtrooper-sprite
                     #:health 50
                     #:amount-in-world 5))
 
  (define (hard-enemy)
    (basic-imperial #:ai 'hard
                     #:sprite bobafett-sprite
                     #:health 200))
 
  (starwars-game
   #:imperial-list (list (easy-enemy) (hard-enemy)))
  )

(define-example-code battlearena-starwars alt/enemy-5
  (define (hard-enemy)
    (basic-imperial #:ai              'hard
                     #:sprite          darthvader-sprite
                     #:amount-in-world 5
                     #:weapon          (lightsaber #:damage 50)))
 
  (starwars-game
   #:imperial-list (list (easy-enemy) (hard-enemy)))
  )

; ---------------

(define-example-code battlearena-starwars alt/enemy-weapon-1
  (starwars-game 
   #:imperial-list (list (basic-imperial
                       #:weapon (blaster
                                 #:color "yellow"))))
  )

(define-example-code battlearena-starwars alt/enemy-weapon-2
  (starwars-game 
   #:imperial-list (list (basic-imperial
                       #:sprite darthvader-sprite
                       #:weapon (lightsaber
                                 #:color "red"))))
  )

(define-example-code battlearena-starwars alt/enemy-weapon-3 
  (starwars-game 
   #:imperial-list (list (basic-imperial
                       #:sprite darthmaul-sprite
                       #:weapon (double-lightsaber))))
  )

; ---------------

(define-example-code battlearena-starwars alt/sword-armor-1  
  (starwars-game
   #:item-list (list (basic-armor #:name          "Lightsaber Armor"
                                   #:protects-from "Lightsaber"
                                   #:icon        (make-icon "LA"))))
  )

(define-example-code battlearena-starwars alt/sword-armor-2
  (define (l-armor)
    (basic-armor #:name          "Lightsaber Armor"
                  #:protects-from "Lightsaber"
                  #:icon        (make-icon "LA")
                  #:change-damage (subtract-by 30)
                  #:rarity        'rare))
  
  (starwars-game
   #:item-list (list (l-armor)))
  )

(define-example-code battlearena-starwars alt/sword-armor-3
  (define (l-armor)
    (basic-armor #:name          "Lightsaber Armor"
                  #:protects-from "Lightsaber"
                  #:icon        (make-icon "LA")
                  #:change-damage (subtract-by 30)
                  #:rarity        'rare))
  
  (starwars-game
   #:imperial-list (list (basic-imperial #:sprite darthvader-sprite
                                        #:weapon (lightsaber #:color "red")))
   #:item-list    (list (l-armor)))
  )

; ----------

;If you want to hook into any of the exported
;  syntax:kata-names, this would be the file to do that.
;You can't see them, but they are here, defined by
;  define-example-code/from*

(define-example-code battlearena-starwars lightsaber-1
  (starwars-game
   #:weapon-list (list (lightsaber)))
  )

(define-example-code battlearena-starwars lightsaber-2
  (define (my-lightsaber)
    (lightsaber #:icon   (make-icon "F" "blue")
                #:rarity 'rare))
  
  (starwars-game
   #:weapon-list (list (my-lightsaber)))
  )


(define-example-code battlearena-starwars lightsaber-3
  (define (my-lightsaber)
    (lightsaber #:name       "Flashy"
                #:icon       (make-icon "F" "blue")
                #:rarity     'rare
                #:color      "blue"
                #:damage     50))
  
  (starwars-game
   #:weapon-list (list (my-lightsaber)))
  )

; ----------

(define-example-code battlearena-starwars blaster-1
  (starwars-game
   #:weapon-list (list (blaster)))
  )

(define-example-code battlearena-starwars blaster-2
  (define (my-blaster)
    (blaster
     #:icon   (make-icon "B" "orange")
     #:rarity 'legendary))
  
  (starwars-game
   #:weapon-list (list (my-blaster)))
  )

(define-example-code battlearena-starwars blaster-3
  (define (my-blaster)
    (blaster  #:rarity     'legendary
              #:icon       (make-icon "B" "orange")
              #:color      "orange"
              #:damage     20
              #:durability 25
              #:speed      10
              #:range      70))

  (starwars-game
   #:weapon-list (list (my-blaster)))
  )

; ---------------

(define-example-code battlearena-starwars lightsaber-droid-1
  (starwars-game
   #:weapon-list (list (lightsaber-droid)))
  )

(define-example-code battlearena-starwars lightsaber-droid-2
  (define (ls-droid)
    (lightsaber-droid #:color      "orange"
                      #:damage     75 
                      #:durability 30))

  (starwars-game
   #:weapon-list (list (ls-droid)))
  )

(define-example-code battlearena-starwars lightsaber-droid-3
  (define (ls-droid)
    (lightsaber-droid #:color      "orange"
                      #:damage     75 
                      #:durability 30
                      #:fire-rate  2))

  (starwars-game
   #:weapon-list (list (ls-droid)))
  )

;---------------------

(define-example-code battlearena-starwars blaster-droid-1
  (starwars-game
   #:weapon-list (list (blaster-droid)))
  )

(define-example-code battlearena-starwars blaster-droid-2
  (define (b-droid)
    (blaster-droid #:color     "yellow"
                   #:damage    25
                   #:fire-mode 'spread))
  
  (starwars-game
   #:weapon-list (list (b-droid)))
  )

(define-example-code battlearena-starwars blaster-droid-3
  (define (b-droid)
    (blaster-droid #:color     "yellow"
                   #:damage     15
                   #:speed      10
                   #:range      75
                   #:fire-rate  5
                   #:fire-mode  'homing))
  
  (starwars-game
   #:weapon-list (list (b-droid)))
  )

; ----------
   
(define-example-code battlearena-starwars blaster-armor-1 
  (starwars-game
   #:item-list (list (basic-armor #:name          "Blaster Armor"
                                   #:protects-from "Blaster"
                                   #:icon        (make-icon "BA"))))
  )

(define-example-code battlearena-starwars blaster-armor-2
  (define (b-armor)
    (basic-armor #:name          "Blaster Armor"
                  #:protects-from "Blaster"
                  #:icon        (make-icon "BA")
                  #:change-damage (subtract-by 30)
                  #:rarity        'rare))
  
  (starwars-game
   #:item-list (list (b-armor)))  
  )

(define-example-code battlearena-starwars blaster-armor-3
  (define (b-armor)
    (basic-armor #:name          "Blaster Armor"
                  #:protects-from "Blaster"
                  #:icon        (make-icon "BA")
                  #:change-damage (subtract-by 30)
                  #:rarity        'rare))
  
  (starwars-game
   #:imperial-list (list (basic-imperial))
   #:item-list    (list (b-armor)))
  )

; ----------

;We'll test that the examples all run as games for 10 ticks
(test-all-examples-as-games 'battlearena-starwars)

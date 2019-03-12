#lang racket

(require ts-kata-util
         "./lang/main.rkt"
         battlearena-starwars)


(define-example-code/from* battlearena/examples)

; ---------------

(define-example-code battlearena-starwars alt/avatar-2
 (starwars-game
   #:hero (custom-hero #:sprite yoda-sprite))
  )

(define-example-code battlearena-starwars alt/avatar-3
  (define (my-hero)
    (custom-hero #:sprite     yoda-sprite
                 #:speed      15
                 #:key-mode   'arrow-keys
                 #:item-slots 5))
  (starwars-game
   #:hero (my-hero))
  )

; ---------------

(define-example-code battlearena-starwars alt/enemy-3
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

(define-example-code battlearena-starwars alt/enemy-weapon-1
  (starwars-game 
   #:villain-list (list (custom-villain
                       #:weapon (blaster
                                 #:color "yellow"))))
  )

(define-example-code battlearena-starwars alt/enemy-weapon-2
  (starwars-game 
   #:villain-list (list (custom-villain
                       #:sprite darthvader-sprite
                       #:weapon (lightsaber
                                 #:color "red"))))
  )

(define-example-code battlearena-starwars alt/enemy-weapon-3 
  (starwars-game 
   #:villain-list (list (custom-villain
                       #:sprite darthmaul-sprite
                       #:weapon (double-lightsaber))))
  )

; ---------------

(define-example-code battlearena-starwars alt/sword-armor-1  
  (starwars-game
   #:item-list (list (custom-armor #:name          "Lightsaber Armor"
                                   #:protects-from "Lightsaber"
                                   #:sprite        (make-icon "LA"))))
  )

(define-example-code battlearena-starwars alt/sword-armor-2
  (define (l-armor)
    (custom-armor #:name          "Lightsaber Armor"
                  #:protects-from "Lightsaber"
                  #:sprite        (make-icon "LA")
                  #:change-damage (subtract-by 30)
                  #:rarity        'rare))
  
  (starwars-game
   #:item-list (list (l-armor)))  
  )

(define-example-code battlearena-starwars alt/sword-armor-3
  (define (l-armor)
    (custom-armor #:name          "Lightsaber Armor"
                  #:protects-from "Lightsaber"
                  #:sprite        (make-icon "LA")
                  #:change-damage (subtract-by 30)
                  #:rarity        'rare))
  
  (starwars-game
   #:villain-list (list (custom-villain #:sprite darthvader-sprite
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
    (lightsaber #:name   "Flashy"
                #:icon   (make-icon "F" "blue")
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
     #:name   "Blasty"
     #:icon   (make-icon "B" "orange")
     #:rarity 'legendary))
  
  (starwars-game
   #:weapon-list (list (my-blaster)))
  )

(define-example-code battlearena-starwars blaster-3
  (define (my-blaster)
    (blaster  #:name       "Blasty"
              #:rarity     'legendary
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
   #:weapon-list (list (custom-weapon 
                        #:name   "Lightsaber Droid" 
                        #:sprite (make-icon "LD")
                        #:dart   (lightsaber-droid))))
  )

(define-example-code battlearena-starwars lightsaber-droid-2
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

(define-example-code battlearena-starwars lightsaber-droid-3
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

(define-example-code battlearena-starwars blaster-droid-1
  (starwars-game
   #:weapon-list (list (custom-weapon 
                        #:name   "Blaster Droid" 
                        #:sprite (make-icon "BD")
                        #:dart   (blaster-droid))))
  )

(define-example-code battlearena-starwars blaster-droid-2
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

(define-example-code battlearena-starwars blaster-droid-3
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
   
(define-example-code battlearena-starwars blaster-armor-1 
  (starwars-game
   #:item-list (list (custom-armor #:name          "Blaster Armor"
                                   #:protects-from "Blaster"
                                   #:sprite        (make-icon "BA"))))
  )

(define-example-code battlearena-starwars blaster-armor-2
  (define (b-armor)
    (custom-armor #:name          "Blaster Armor"
                  #:protects-from "Blaster"
                  #:sprite        (make-icon "BA")
                  #:change-damage (subtract-by 30)
                  #:rarity        'rare))
  
  (starwars-game
   #:item-list (list (b-armor)))  
  )

(define-example-code battlearena-starwars blaster-armor-3
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

; ----------

;We'll test that the examples all run as games for 10 ticks
(test-all-examples-as-games 'battlearena-starwars)
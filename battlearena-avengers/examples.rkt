#lang racket

(require ts-kata-util
         battlearena-avengers)

(define-example-code/from* battlearena/examples)

; ---------------

(define-example-code battlearena-avengers alt/avatar-2
 (avengers-game
   #:hero (custom-hero #:sprite thor-sprite))
  )

(define-example-code battlearena-avengers alt/avatar-3
  (define (my-hero)
    (custom-hero #:sprite     hulk-sprite
                 #:speed      15))
  
  (avengers-game
   #:hero (my-hero))
  )

(define-example-code battlearena-avengers alt/avatar-4
  (define (my-hero)
    (custom-hero #:sprite     starlord-sprite
                 #:speed      20
                 #:key-mode   'arrow-keys
                 #:item-slots 5))
  (avengers-game
   #:hero (my-hero))
  )

(define-example-code battlearena-avengers alt/avatar-5
  (define (my-hero)
    (custom-hero #:sprite     drax-sprite
                 #:speed      25
                 #:item-slots 5
                 #:health     200
                 #:max-health 200
                 #:shield     200
                 #:max-shield 200 ))
  
  (avengers-game
   #:hero (my-hero))
  )

; ---------------

(define-example-code battlearena-avengers alt/enemy-3
  (define (my-villain)
    (custom-villain #:sprite          loki-sprite
                    #:ai              'medium
                    #:health          200
                    #:shield          100
                    #:amount-in-world 5))
  
  (avengers-game 
   #:villain-list (list (my-villain)))
  )

(define-example-code battlearena-avengers alt/enemy-4
  (define (easy-villain)
    (custom-villain #:sprite          wintersoldier-sprite
                    #:ai              'easy
                    #:health          50
                    #:amount-in-world 5))

  (define (hard-villain)
    (custom-villain #:sprite          redskull-sprite
                    #:ai              'hard
                    #:health          200
                    #:amount-in-world 3))
  
  (avengers-game 
   #:villain-list (list (easy-villain)
                        (hard-villain)))
  )

; ---------------

(define-example-code battlearena-avengers alt/enemy-weapon-1
  (avengers-game
   #:villain-list (list (custom-villain
                         #:power (energy-blast
                                   #:color 'yellow))))
  )

(define-example-code battlearena-avengers alt/enemy-weapon-2
  (avengers-game
   #:villain-list (list (custom-villain
                         #:sprite mandarin-sprite
                         #:power (ring-of-fire
                                   #:color 'purple))))
  )

(define-example-code battlearena-avengers alt/enemy-weapon-3
  (define (my-power)
    (ring-of-fire #:damage 50
                  #:speed  10
                  #:duration  20
                  #:color 'purple))
  (avengers-game
   #:villain-list (list (custom-villain
                         #:sprite mandarin-sprite
                         #:power (my-power))))
  )

; ---------------

;If you want to hook into any of the exported
;  syntax:kata-names, this would be the file to do that.
;You can't see them, but they are here, defined by
;  define-example-code/from*

; ---------------

(define-example-code battlearena-avengers power-1
  (avengers-game
   #:power-list (list (energy-blast)))
  )

(define-example-code battlearena-avengers power-2
  (avengers-game
   #:power-list (list (energy-blast #:color 'orange
                                    #:damage 20)))
  )

(define-example-code battlearena-avengers power-3
  (define (my-power)
    (star-bit #:color 'orange
              #:damage 10
              #:speed 15
              #:rarity 'legendary))
  
  (avengers-game
   #:power-list (list (my-power)))
  )

(define-example-code battlearena-avengers power-4
  (define (my-power-1)
    (magic-orb #:damage      10
               #:speed       15
               #:fire-mode   'spread
               #:rapid-fire? #f))
                  
  (define (my-power-2)
    (hammer #:color     'red
            #:damage    15
            #:speed     10
            #:rarity    'rare))
  
  (avengers-game
   #:power-list (list (my-power-1)
                      (my-power-2)))
  )

; ---------------

(define-example-code battlearena-avengers drone-1
  (avengers-game
    #:power-list (list (energy-drone)))
  )

(define-example-code battlearena-avengers drone-2
  (define (my-drone)
    (energy-drone #:color     'yellow
                  #:fire-mode 'spread))
    
  (avengers-game
   #:power-list (list (my-drone)))
  )

(define-example-code battlearena-avengers drone-3
  (define (my-drone)
    (energy-drone #:color     'red
                  #:damage    50
                  #:fire-rate 3
                  #:fire-mode 'homing))
    
  (avengers-game
   #:power-list (list (my-drone)))
  )

; ---------------


(define-example-code battlearena-avengers armor-1
  (avengers-game
   #:item-list (list (custom-armor #:name "Energy Armor"
                                   #:protects-from "Energy Blast"
                                   #:icon (make-icon "EA"))))
  )

(define-example-code battlearena-avengers armor-2
  (avengers-game
   #:item-list (list (custom-armor #:name "Energy Armor"
                                   #:protects-from "Energy Blast"
                                   #:icon (make-icon "EA")
                                   #:change-damage (subtract-by 10))))
  )

(define-example-code battlearena-avengers armor-3
  (define (energy-armor)
    (custom-armor #:name "Energy Armor"
                  #:protects-from "Energy Blast"
                  #:icon (make-icon "LA")
                  #:change-damage (subtract-by 10)
                  #:rarity 'rare))
  (avengers-game
    #:item-list (list (energy-armor)))
  )

; ---------------
;We'll test that the examples all run as games for 10 ticks
(test-all-examples-as-games 'battlearena-avengers)

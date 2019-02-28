#lang racket

(require ts-kata-util
         "./lang/main.rkt"
         battle-arena-avengers)

(define-example-code/from* battle-arena/examples)

; ---------------

(define-example-code battle-arena-avengers alt/avatar-2
 (avengers-game
   #:hero (custom-hero #:sprite thor-sprite))
  )

(define-example-code battle-arena-avengers alt/avatar-3
  (define (my-hero)
    (custom-hero #:sprite     thor-sprite
                 #:speed      15
                 #:key-mode   'arrow-keys
                 #:item-slots 5))
  (avengers-game
   #:hero (my-hero))
  )

; ---------------

(define-example-code battle-arena-avengers alt/enemy-3
  (define (my-enemy)
    (custom-villain #:sprite          loki-sprite
                    #:ai              'medium
                    #:health          200
                    #:shield          100
                    #:amount-in-world 5))
  
  (avengers-game 
   #:villain-list (list (my-enemy)))
  )

; ---------------

(define-example-code battle-arena-avengers alt/enemy-weapon-1
  (avengers-game
   #:villain-list (list (custom-villain
                         #:power (custom-power
                                   #:color 'yellow))))
  )

(define-example-code battle-arena-avengers alt/enemy-weapon-2
  (avengers-game
   #:villain-list (list (custom-villain
                         #:sprite mandarin-sprite
                         #:power (custom-power
                                   #:dart (ring-of-fire-dart)
                                   #:color 'purple))))
  )

(define-example-code battle-arena-avengers alt/enemy-weapon-3
  (define (my-power)
    (custom-power #:dart (ring-of-fire-dart #:damage 50
                                            #:speed  10
                                            #:duration  20)
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

(define-example-code battle-arena-avengers power-1
  (avengers-game
   #:power-list (list (custom-power)))
  )

(define-example-code battle-arena-avengers power-2
  (avengers-game
   #:power-list (list (custom-power #:name "Energy Blast"
                                    #:icon (make-icon "EB" 'orange)
                                    #:dart (energy-blast #:color 'orange))))
  )

(define-example-code battle-arena-avengers power-3
  (define (my-power)
    (custom-power #:name "Energy Blast"
                  #:icon (make-icon "EB" 'orange)
                  #:dart (energy-blast #:color 'orange)
                  #:rarity 'legendary))
  
  (avengers-game
   #:power-list (list (my-power)))
  )

(define-example-code battle-arena-avengers power-4
  (define (my-energy)
    (energy-blast #:color      'orange
                  #:damage     20
                  #:durability 25
                  #:speed      10
                  #:range      70))
                  
  (define (my-power)
    (custom-power #:name "Energy Blast"
                  #:icon (make-icon "EB" 'orange)
                  #:dart (my-energy)
                  #:rarity 'legendary))
  
  (avengers-game
   #:power-list (list (my-power)))
  )

(define-example-code battle-arena-avengers power-5
  (define (my-power-1)
    (custom-power #:name "Energy Blast"
                  #:icon (make-icon "EB" 'orange)
                  #:dart (energy-blast)
                  #:rarity 'legendary))
                  
  (define (my-power-2)
    (custom-power #:name "Hammer"
                  #:icon (make-icon "H" 'gray)
                  #:dart (flying-hammer)
                  #:rarity 'rare))
  
  (avengers-game
   #:power-list (list (my-power-1)
                      (my-power-2)))
  )

; ---------------

(define-example-code battle-arena-avengers droid-1
  (avengers-game
    #:power-list (list (custom-power #:name "Droid"
                                     #:icon (make-icon "D" 'yellow)
                                     #:dart (energy-droid))))
  )

(define-example-code battle-arena-avengers droid-2
  (define (my-droid)
    (custom-power #:name "Droid"
                  #:icon (make-icon "D" 'yellow)
                  #:dart (energy-droid #:color 'yellow
                                       #:damage 25
                                       #:fire-rate 2
                                       #:fire-mode 'spread)))
    
  (avengers-game
   #:power-list (list (my-droid)))
  )

(define-example-code battle-arena-avengers droid-3
  (define (my-droid)
    (custom-power #:name "Droid"
                  #:icon (make-icon "D" 'yellow)
                  #:dart (energy-droid #:color 'yellow
                                       #:damage 25)))
    
  (avengers-game
   #:power-list (list (my-droid)))
  )

; ---------------


(define-example-code battle-arena-avengers armor-1
  (avengers-game
   #:item-list (list (custom-armor #:name "Energy Armor"
                                   #:protects-from "Energy Blast"
                                   #:sprite (make-icon "EA"))))
  )

(define-example-code battle-arena-avengers armor-2
  (avengers-game
   #:item-list (list (custom-armor #:name "Energy Armor"
                                   #:protects-from "Energy Blast"
                                   #:sprite (make-icon "EA")
                                   #:change-damage (subtract-by 10))))
  )

(define-example-code battle-arena-avengers armor-3
  (define (energy-armor)
    (custom-armor #:name "Energy Armor"
                  #:protects-from "Energy Blast"
                  #:sprite (make-icon "LA")
                  #:change-damage (subtract-by 10)
                  #:rarity 'rare))
  (avengers-game
    #:item-list (list (energy-armor)))
  )

; ---------------
;We'll test that the examples all run as games for 10 ticks
(test-all-examples-as-games 'battle-arena-avengers)
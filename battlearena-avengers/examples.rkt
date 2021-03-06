#lang racket

(require ts-kata-util
         battlearena-avengers)

(define-example-code/from* battlearena/examples)

; ---------------

(define-example-code
  ;#:with-test (test game-test)
 battlearena-avengers alt/avatar-2
 (avengers-game
   #:hero (basic-hero #:sprite thor-sprite))
  )

(define-example-code
  ;#:with-test (test game-test)
 battlearena-avengers alt/avatar-3
  (define (my-hero)
    (basic-hero #:sprite     hulk-sprite
                 #:speed      15))
  
  (avengers-game
   #:hero (my-hero))
  )

(define-example-code
  ;#:with-test (test game-test)
 battlearena-avengers alt/avatar-4
 (define (my-hero)
    (basic-hero #:sprite     drax-sprite
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

(define-example-code
  ;#:with-test (test game-test)
 battlearena-avengers alt/enemy-3
  (define (my-villain)
    (basic-villain #:sprite          loki-sprite
                    #:ai              'medium
                    #:health          200
                    #:shield          100
                    #:amount-in-world 5))
  
  (avengers-game 
   #:villain-list (list (my-villain)))
  )

(define-example-code
  ;#:with-test (test game-test)
 battlearena-avengers alt/enemy-4
  (define (easy-villain)
    (basic-villain #:sprite          wintersoldier-sprite
                    #:ai              'easy
                    #:health          50
                    #:amount-in-world 5))

  (define (hard-villain)
    (basic-villain #:sprite          redskull-sprite
                    #:ai              'hard
                    #:health          200
                    #:amount-in-world 3))
  
  (avengers-game 
   #:villain-list (list (easy-villain)
                        (hard-villain)))
  )

; ---------------

(define-example-code
  ;#:with-test (test game-test)
 battlearena-avengers alt/enemy-weapon-1
  (avengers-game
   #:villain-list (list (basic-villain
                         #:power (energy-blast
                                   #:color 'yellow))))
  )

(define-example-code
  ;#:with-test (test game-test)
 battlearena-avengers alt/enemy-weapon-2
  (avengers-game
   #:villain-list (list (basic-villain
                         #:sprite mandarin-sprite
                         #:power (ring-of-fire
                                   #:color 'purple))))
  )

(define-example-code
  ;#:with-test (test game-test)
 battlearena-avengers alt/enemy-weapon-3
  (define (my-power)
    (ring-of-fire #:damage 50
                  #:speed  10
                  #:duration  20
                  #:color 'purple))
  (avengers-game
   #:villain-list (list (basic-villain
                         #:sprite mandarin-sprite
                         #:power (my-power))))
  )

; ---------------

;If you want to hook into any of the exported
;  syntax:kata-names, this would be the file to do that.
;You can't see them, but they are here, defined by
;  define-example-code/from*

; ---------------

(define-example-code
  ;#:with-test (test game-test)
 battlearena-avengers power-1
  (avengers-game
   #:power-list (list (energy-blast)))
  )

(define-example-code
  ;#:with-test (test game-test)
 battlearena-avengers power-2
  (avengers-game
   #:power-list (list (energy-blast #:color 'orange
                                    #:damage 20)))
  )

(define-example-code
  ;#:with-test (test game-test)
 battlearena-avengers power-3
  (define (my-power)
    (star-bit #:color 'orange
              #:damage 10
              #:speed 15
              #:rarity 'legendary))
  
  (avengers-game
   #:power-list (list (my-power)))
  )

(define-example-code
  ;#:with-test (test game-test)
 battlearena-avengers power-4
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

(define-example-code
  ;#:with-test (test game-test)
 battlearena-avengers drone-1
  (avengers-game
    #:power-list (list (energy-drone)))
  )

(define-example-code
  ;#:with-test (test game-test)
 battlearena-avengers drone-2
  (define (my-drone)
    (energy-drone #:color     'yellow
                  #:fire-mode 'spread))
    
  (avengers-game
   #:power-list (list (my-drone)))
  )

(define-example-code
  ;#:with-test (test game-test)
 battlearena-avengers drone-3
  (define (my-drone)
    (energy-drone #:color     'red
                  #:damage    50
                  #:fire-rate 3
                  #:fire-mode 'homing))
    
  (avengers-game
   #:power-list (list (my-drone)))
  )

; ---------------


(define-example-code
  ;#:with-test (test game-test)
 battlearena-avengers armor-1
  (avengers-game
   #:item-list (list (basic-armor #:name "Energy Armor"
                                   #:protects-from "Energy Blast"
                                   #:icon (make-icon "EA"))))
  )

(define-example-code
  ;#:with-test (test game-test)
 battlearena-avengers armor-2
  (avengers-game
   #:item-list (list (basic-armor #:name "Energy Armor"
                                   #:protects-from "Energy Blast"
                                   #:icon (make-icon "EA")
                                   #:change-damage (subtract-by 10))))
  )

(define-example-code
  ;#:with-test (test game-test)
 battlearena-avengers armor-3
  (define (energy-armor)
    (basic-armor #:name "Energy Armor"
                  #:protects-from "Energy Blast"
                  #:icon (make-icon "LA")
                  #:change-damage (subtract-by 10)
                  #:rarity 'rare))
  (avengers-game
    #:item-list (list (energy-armor)))
  )
; ---------------

(define-example-code
  ;#:with-test (test game-test)
 battlearena-avengers alt/background-4
  (define (my-planet)
    (basic-planet #:image LAVA-BG
                  #:rows 2
                  #:columns 2
                  #:start-tile 3
                  #:hd? #t))
 
  (avengers-game #:planet (my-planet))
  )


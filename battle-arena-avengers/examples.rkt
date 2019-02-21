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
                                   #:color "yellow"))))
  )

(define-example-code battle-arena-avengers alt/enemy-weapon-2
  (avengers-game
   #:villain-list (list (custom-villain
                         #:sprite mandarin-sprite
                         #:power (custom-power
                                   #:dart (ring-of-fire)
                                   #:color "purple"))))
  )

(define-example-code battle-arena-avengers alt/enemy-weapon-3
  (define (my-power)
    (custom-power #:dart (ring-of-fire #:damage 50
                                       #:speed  10
                                       #:range  20)
                  #:color "purple"))
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

#;(define-example-code battle-arena-avengers xxx-1
    (avengers-game)
    )

;We'll test that the examples all run as games for 10 ticks
;(test-all-examples-as-games 'battle-arena-avengers)
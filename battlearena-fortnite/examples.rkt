#lang racket

(require ts-kata-util
         "./lang/main.rkt"
         battlearena-fortnite)

(define-example-code/from* battlearena/examples)

; ---------------

(define-example-code battlearena-fortnite alt/avatar-2
 (fortnite-game
   #:hero (custom-hero #:sprite constructor-sprite))
  )

(define-example-code battlearena-fortnite alt/avatar-3
  (define (my-hero)
    (custom-hero #:sprite     ninja-sprite
                 #:speed      20
                 #:key-mode   'arrow-keys
                 #:item-slots 5))
  (fortnite-game
   #:hero (my-hero))
  )


; ---------------
;We'll test that the examples all run as games for 10 ticks
(test-all-examples-as-games 'battlearena-fortnite)
#lang racket

(require ts-kata-util
         "./lang/main.rkt"
         battlearena-fortnite)

(define-example-code/from* battlearena/examples)

; ---------------

(define-example-code 
  ;#:with-test (test game-test)
  battlearena-fortnite alt/avatar-2
 (fortnite-game
   #:avatar (basic-avatar #:sprite constructor-sprite))
  )

(define-example-code 
  ;#:with-test (test game-test)
  battlearena-fortnite alt/avatar-3
  (define (my-avatar)
    (basic-avatar #:sprite     ninja-sprite
                   #:speed      20
                   #:key-mode   'arrow-keys
                   #:item-slots 5))
  (fortnite-game
   #:avatar (my-avatar))
  )



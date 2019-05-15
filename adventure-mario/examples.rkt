#lang racket

(require ts-kata-util
         "./lang/main.rkt"
         adventure-mario)

(define-example-code/from* adventure/examples)

; ---------------

(define-example-code adventure-mario alt/avatar-2
 (mario-game
   #:character (custom-character #:sprite bigmario01-sprite))
  )

(define-example-code adventure-mario alt/avatar-3
  (define (my-character)
    (custom-character #:sprite     bigmario02-sprite
                      #:speed      15))
  
  (mario-game
   #:character (my-character))
  )

(define-example-code adventure-mario alt/avatar-4
  (define (my-character)
    (custom-character #:sprite     bigmario03-sprite
                      #:speed      20
                      #:key-mode   'arrow-keys))
  
  (mario-game
   #:character (my-character))
  )

; ---------------


;We'll test that the examples all run as games for 10 ticks
(test-all-examples-as-games 'adventure-mario)
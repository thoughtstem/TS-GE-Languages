#lang racket

(require ts-kata-util
         "./lang/main.rkt"
         survival-pokemon)

(define-example-code/from* survival/examples)



;(define-example-code battle-arena-avengers alt/avatar-2
; (avengers-game
;   #:hero (custom-hero #:sprite thor-sprite))
;  )

;(define-example-code battle-arena-avengers power-1
;  (avengers-game
;   #:power-list (list (custom-power)))
;  )


(test-all-examples-as-games 'survival-pokemon)

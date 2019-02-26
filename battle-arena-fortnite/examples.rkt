#lang racket

(require ts-kata-util
         "./lang/main.rkt"
         battle-arena-fortnite)

(define-example-code/from* battle-arena/examples)

; ---------------
;We'll test that the examples all run as games for 10 ticks
(test-all-examples-as-games 'battle-arena-fortnite)
#lang racket

(require ts-kata-util
         "./lang/main.rkt")


(define-example-code/from* battle-arena/examples)
(define-example-code/from* battle-arena-starwars/examples/main)

;If you want to hook into any of the exported
;  syntax:kata-names, this would be the file to do that.
;You can't see them, but they are here, defined by
;  define-example-code/from*

;We'll test that the examples all run as games for 10 ticks
;(test-all-examples-as-games 'battle-arena-starwars)
#lang racket

(require ts-kata-util
         "./lang/main.rkt")

(define-example-code/from* survival/examples)


;Tests all examples as games for 10 ticks
(test-all-examples-as-games 'survival-minecraft)




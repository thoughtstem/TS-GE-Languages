#lang racket

(require ts-kata-util)


(define-example-code #:with-test (test begin)
  fundamentals hello-world 

  (circle 40 'solid 'red))

(define-example-code #:with-test (test begin)
  fundamentals target 

  (overlay
   (circle 10 'solid 'red)
   (circle 15 'solid 'white)
   (circle 20 'solid 'red)
   (circle 25 'solid 'white)
   (circle 30 'solid 'red)))


;Function defs

(define-example-code #:with-test (test begin)
  fundamentals func-defs-000 

  (define (foo)
    42) 
  
  (foo))



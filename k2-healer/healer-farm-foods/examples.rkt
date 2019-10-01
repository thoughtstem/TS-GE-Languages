#lang racket

(require healer-lib/examples-lib
         "./main.rkt")

(define-food-examples 
  #:lang healer-farm-foods
  #:start start
  #:avatars (chicken llama horse rabbit)
  #:foods   (apple broccoli grapes onion)
  #:rand rand)

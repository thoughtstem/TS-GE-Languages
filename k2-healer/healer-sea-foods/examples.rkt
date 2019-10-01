#lang racket

(require healer-lib/examples-lib "./main.rkt")

(define-food-examples
  #:lang healer-sea-foods
  #:start start
  #:avatars (yellow-fish green-fish red-fish crab)
  #:foods   (pineapple broccoli kiwi tomato)
  #:rand rand)

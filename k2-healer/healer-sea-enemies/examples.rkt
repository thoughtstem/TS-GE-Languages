#lang racket

(require healer-lib/examples-lib "./main.rkt")

(define-enemies-examples
  #:lang healer-sea-enemies
  #:start start
  #:avatars (shark ghost-fish red-fish orange-fish)
  #:foods   (potato cherries mushroom strawberry)
  #:friends (jellyfish octopus crab shark)
  #:colors  (yellow orange red green)
  #:enemies (shark ghost-fish red-fish orange-fish)
  #:rand rand)

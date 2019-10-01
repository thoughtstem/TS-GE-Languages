#lang racket

(require healer-lib/examples-lib "./main.rkt"  )

(define-friends-examples
  #:lang healer-sea-friends
  #:start start
  #:avatars (orange-fish jellyfish octopus crab)
  #:foods   (apple kiwi mushroom pineapple)
  #:friends (shark ghost-fish red-fish orange-fish)
  #:colors (red orange yellow blue)
  #:rand rand)

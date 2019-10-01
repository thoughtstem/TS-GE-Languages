#lang racket

(require healer-lib/examples-lib "./main.rkt")

(define-friends-examples
  #:lang healer-zoo-friends
  #:start start
  #:avatars (zookeeper elephant hippo kangaroo)
  #:foods   (apple banana fish tomato)
  #:friends (monkey penguin kangaroo elephant)
  #:colors (red orange yellow blue)
  #:rand rand)

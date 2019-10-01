#lang racket

(require healer-lib/examples-lib "./main.rkt")

(define-enemies-examples
  #:lang healer-zoo-enemies
  #:start start
  #:avatars (monkey elephant hippo kangaroo)
  #:foods   (apple banana fish tomato)
  #:friends (penguin zookeeper monkey elephant)
  #:colors  (yellow orange red green)
  #:enemies (monkey elephant hippo kangaroo)
  #:rand rand)

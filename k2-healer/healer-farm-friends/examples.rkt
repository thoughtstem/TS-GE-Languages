#lang racket

(require healer-lib/examples-lib "./main.rkt")

(define-friends-examples
  #:lang healer-farm-friends
  #:start start
  #:avatars (llama cow rabbit sheep)
  #:foods   (apple banana potato kiwi)
  #:friends (llama cow rabbit sheep)
  #:colors (red green blue purple)
  #:rand rand)

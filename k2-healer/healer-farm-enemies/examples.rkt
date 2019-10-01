#lang racket

(require healer-lib/examples-lib "./main.rkt")

(define-enemies-examples 
  #:lang healer-farm-enemies
  #:start start
  #:avatars (llama horse cow rabbit)
  #:foods   (apple grapes kiwi pepper)
  #:friends (sheep dog wolf llama)
  #:colors  (yellow orange red green)
  #:enemies (sheep dog wolf llama)
  #:rand rand)

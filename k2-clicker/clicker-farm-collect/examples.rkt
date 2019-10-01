#lang racket

(require clicker-lib/examples-lib 
         ts-kata-util
         ts-kata-util/inline-stimuli)

(define-simple-examples 
  #:lang clicker-farm-collect
  #:start start-forest
  #:pointers (pointer cage magic-wand glove)
  #:collectables   (apple kiwi dog horse)
  #:avoidables     (rabbit dog horse apple)
  #:specials       (freeze slow light)
  #:colors  (yellow orange red green)
  #:rand rand)

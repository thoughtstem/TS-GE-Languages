#lang racket

(provide 
  (all-from-out 
    "./examples/hero.rkt"
    "./examples/zoo.rkt"
    "./examples/sea.rkt"
    "./examples/farm.rkt"))

(require 
  "./examples/hero.rkt"
  "./examples/zoo.rkt"
  "./examples/sea.rkt"
  "./examples/farm.rkt")

(module+ test
  (require 
    (submod "./examples/hero.rkt" test)

    (submod "./examples/zoo.rkt" test)

    (submod "./examples/sea.rkt" test)    
    (submod"./examples/farm.rkt" test)))

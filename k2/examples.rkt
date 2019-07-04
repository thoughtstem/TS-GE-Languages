#lang racket

(provide 
  (all-from-out 
    "./examples/hero.rkt"
    "./examples/zoo.rkt"
    "./examples/sea.rkt"
    "./examples/farm.rkt"
    "./examples/animal.rkt"))

(require 
  "./examples/hero.rkt"
  "./examples/zoo.rkt"
  "./examples/sea.rkt"
  "./examples/farm.rkt"
  "./examples/animal.rkt")

(module+ test
  (require 
    (submod "./examples/hero.rkt" test)

    (submod "./examples/zoo.rkt" test)

    (submod "./examples/sea.rkt" test)    
    (submod "./examples/farm.rkt" test)
    (submod "./examples/animal.rkt" test)))

(module+ syntaxes
  (provide
    (all-from-out 
      (submod "./examples/hero.rkt" syntaxes)

      (submod "./examples/zoo.rkt" syntaxes)

      (submod "./examples/sea.rkt" syntaxes)    
      (submod "./examples/farm.rkt" syntaxes)
      (submod "./examples/animal.rkt" syntaxes)))

  (require 
    (submod "./examples/hero.rkt" syntaxes)

    (submod "./examples/zoo.rkt" syntaxes)

    (submod "./examples/sea.rkt" syntaxes)    
    (submod "./examples/farm.rkt" syntaxes)
    (submod "./examples/animal.rkt" syntaxes))
  )

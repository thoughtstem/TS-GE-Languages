#lang racket

(module food-module racket
  (provide (all-from-out "../animal/animal-asset-friendly-names.rkt"
                         "../animal/animal-lang.rkt")
           (rename-out [start-a start]))

  (require "../animal/animal-asset-friendly-names.rkt"
           "../animal/animal-lang.rkt"))

(require 'food-module)
(provide (all-from-out racket 'food-module))
#lang racket

(module coin-module racket
  (provide (all-from-out "../animal/animal-asset-friendly-names.rkt"
                         "../animal/animal-lang.rkt")
           (rename-out [start-b start]))

  (require "../animal/animal-asset-friendly-names.rkt"
           "../animal/animal-lang.rkt"))

(require 'coin-module)
(provide (all-from-out racket 'coin-module))
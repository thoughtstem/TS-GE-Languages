#lang racket

(module sea-foods racket
  (provide (all-from-out "../animal/animal-lang.rkt"
                         "../animal/animal-asset-friendly-names.rkt")
           (rename-out [start-sea-a start]))

  (require"../animal/animal-lang.rkt"
         "../animal/animal-asset-friendly-names.rkt"))

(require 'sea-foods)
(provide (all-from-out racket 'sea-foods))
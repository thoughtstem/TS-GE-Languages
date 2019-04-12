#lang racket

(module sea-coins racket
  (provide (all-from-out "../animal/animal-lang.rkt"
                         "../animal/animal-asset-friendly-names.rkt")
           (rename-out [start-sea-b start]))

  (require"../animal/animal-lang.rkt"
         "../animal/animal-asset-friendly-names.rkt"))

(require 'sea-coins)
(provide (all-from-out racket 'sea-coins))
#lang racket

(module sea-enemies racket
  (provide (all-from-out "../animal/animal-lang.rkt"
                         "../animal/animal-asset-friendly-names.rkt")
           (rename-out [start-sea-c start]))

  (require"../animal/animal-lang.rkt"
         "../animal/animal-asset-friendly-names.rkt"))

(require 'sea-enemies)
(provide (all-from-out racket 'sea-enemies))
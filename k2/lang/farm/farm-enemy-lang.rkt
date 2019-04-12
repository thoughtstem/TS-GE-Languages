#lang racket

(module enemy-module racket
  (provide (all-from-out "../animal/animal-asset-friendly-names.rkt"
                         "../animal/animal-lang.rkt")
           (rename-out [start-c start]))

  (require "../animal/animal-asset-friendly-names.rkt"
           "../animal/animal-lang.rkt"))

(require 'enemy-module)
(provide (all-from-out racket 'enemy-module))
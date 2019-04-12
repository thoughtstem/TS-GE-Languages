#lang racket

(module sea-friends racket
  (provide (all-from-out "../animal/animal-lang.rkt"
                         "../animal/animal-asset-friendly-names.rkt")
           (rename-out [start-sea-npc start]))

  (require"../animal/animal-lang.rkt"
         "../animal/animal-asset-friendly-names.rkt"))

(require 'sea-friends)
(provide (all-from-out racket 'sea-friends))
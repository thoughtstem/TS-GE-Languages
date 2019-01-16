#lang at-exp racket

(module reader syntax/module-reader
   starwars-battle-arena)

(provide (all-from-out "./lang.rkt"))
(provide (all-from-out "./assets.rkt"))

(require "./lang.rkt")
(require "./assets.rkt")


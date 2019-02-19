#lang at-exp racket

(module reader syntax/module-reader
   battle-arena-starwars)

(provide (all-from-out "./lang.rkt"))

(require "./lang.rkt")
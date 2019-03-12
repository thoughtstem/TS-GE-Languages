#lang at-exp racket

(module reader syntax/module-reader
   battlearena-starwars)

(provide (all-from-out "./lang.rkt"))

(require "./lang.rkt")
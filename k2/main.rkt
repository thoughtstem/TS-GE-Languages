#lang at-exp racket

(module reader syntax/module-reader
   k2)

(provide (all-from-out "./lang.rkt")
         (all-from-out "./assets.rkt"))

(require "./lang.rkt")
(require "./assets.rkt")

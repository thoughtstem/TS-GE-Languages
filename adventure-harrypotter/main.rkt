#lang at-exp racket

(module reader syntax/module-reader
   adventure-harrypotter)

(provide (all-from-out "./lang.rkt"))

(require "./lang.rkt")

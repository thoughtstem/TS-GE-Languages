#lang at-exp racket

(module reader syntax/module-reader
   adventure-mario)

(provide (all-from-out "./lang.rkt"))

(require "./lang.rkt")

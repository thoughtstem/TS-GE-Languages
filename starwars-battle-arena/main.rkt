#lang at-exp racket

(require scribble/srcdoc
         scribble/extract)

(require (for-doc racket/base scribble/manual))

(provide-extracted "./lang/main.rkt")

(module reader syntax/module-reader
   starwars-battle-arena)

(provide (all-from-out "./lang.rkt"))

(require "./lang.rkt")

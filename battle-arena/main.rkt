#lang at-exp racket

(require scribble/srcdoc
         scribble/extract)

(require (for-doc racket/base scribble/manual))

(module reader syntax/module-reader
    battle-arena/lang)

(provide (all-from-out "./lang.rkt"))
(provide (all-from-out "./assets.rkt"))

(require "./lang.rkt")
(require "./assets.rkt")

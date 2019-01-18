#lang at-exp racket

(require scribble/srcdoc
         scribble/extract)

(require (for-doc racket/base scribble/manual))

(module reader syntax/module-reader
    battle-arena/jam-lang)

(provide (all-from-out "./jam-lang.rkt"))

(require "./jam-lang.rkt")

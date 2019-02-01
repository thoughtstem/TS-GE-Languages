#lang racket

(require scribble/srcdoc
         scribble/extract)

(require (for-doc racket/base scribble/manual))

(module reader syntax/module-reader
  survival/lang)

(provide (all-from-out "./lang.rkt"
                       "./browsable-assets.rkt"))

(require "./lang.rkt"
         "./browsable-assets.rkt")

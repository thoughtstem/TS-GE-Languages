#lang racket

(module reader syntax/module-reader
  survival/lang)

(provide (all-from-out "./lang.rkt"
                       ;"./browsable-assets.rkt"
                       ))

(require "./lang.rkt"
         ;"./browsable-assets.rkt"
         )

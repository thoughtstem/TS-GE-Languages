#lang racket

;if using #lang survival
(module reader syntax/module-reader
  survival/lang)

;if you (require survival)
(provide (all-from-out "./lang.rkt"
                       ;"./browsable-assets.rkt"
                       ))
(require "./lang.rkt"
         ;"./browsable-assets.rkt"
         )

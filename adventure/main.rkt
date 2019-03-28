#lang racket

;if using #lang adventure
(module reader syntax/module-reader
  adventure/lang)

;if you (require adventure)
(provide (all-from-out "./lang.rkt"))
(require "./lang.rkt")

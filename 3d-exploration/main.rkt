#lang racket

;if using #lang 3d-exploration
(module reader syntax/module-reader
  3d-exploration/lang)

;if you (require 3d-exploration)
(provide (all-from-out "./lang.rkt"))
(require "./lang.rkt")

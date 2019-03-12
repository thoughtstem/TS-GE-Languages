#lang at-exp racket

;If you #lang battlearena
(module reader syntax/module-reader
    battlearena/lang)

;If you (require battlearena)
(provide (all-from-out "./lang.rkt"))
(require "./lang.rkt")

#lang at-exp racket

;If you #lang battle-arena
(module reader syntax/module-reader
    battle-arena/lang)

;If you (require battle-arena)
(provide (all-from-out "./lang.rkt"))
(require "./lang.rkt")

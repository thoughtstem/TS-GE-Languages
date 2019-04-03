
#lang racket

(provide (all-from-out "./sea-lang.rkt"))
(require "./sea-lang.rkt")

(module reader syntax/module-reader
  k2/lang/sea/sea-lang)

(module ratchet racket
  
  (require ratchet
           (submod "./sea-lang.rkt" sea-stuff)
           "../icons.rkt"
           (prefix-in s: survival)
           (prefix-in h: 2htdp/image))

  (define (crop i)
    (h:crop 0 0 32 32 i))

  (define-visual-language sea-lang
    (submod "./sea-lang.rkt" sea-stuff)
    [fish          f (crop s:CAT-SHEET)]

    [start         s play-icon]))



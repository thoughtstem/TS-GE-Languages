#lang racket

(provide (all-from-out "./animal-lang.rkt"))
(require "./animal-lang.rkt")

(module reader syntax/module-reader
  k2/lang/animal/animal-lang)

(module ratchet racket 
  (require ratchet
           (submod "./animal-lang.rkt" animal-stuff)
           "../icons.rkt"
           (prefix-in s: survival)
           (prefix-in h: 2htdp/image))

  (define (crop i)
    (h:crop 0 0 32 32 i))

  (define-visual-language animal-lang
    (submod "./animal-lang.rkt" animal-stuff)
    [cat     c (crop s:CAT-SHEET)]

    [start   s play-icon]))



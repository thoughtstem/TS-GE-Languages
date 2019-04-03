
#lang racket

(provide (all-from-out "./zoo-lang.rkt"))
(require "./zoo-lang.rkt")

(module reader syntax/module-reader
  k2/lang/zoo/zoo-lang)

(module ratchet racket
  
  (require ratchet
           (submod "./zoo-lang.rkt" zoo-stuff)
           "../icons.rkt"
           (prefix-in s: survival)
           (prefix-in h: 2htdp/image)
           ;(prefix-in p: pict)
           ;(prefix-in p: pict/flash)
           )

  (define (crop i)
    (h:crop 0 0 32 32 i))

  (define-visual-language zoo-lang
    (submod "./zoo-lang.rkt" zoo-stuff)
    [zookeeper      z (crop s:mystery-sheet)]   
    [tiger          t (crop s:CAT-SHEET)]
    [panther        p (crop s:BLACK-CAT-SHEET)]

    [start         s play-icon]))



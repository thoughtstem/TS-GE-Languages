#lang racket

(provide (all-from-out "./farm-lang.rkt"))
(require "./farm-lang.rkt")

(module reader syntax/module-reader
  k2/lang/farm/farm-lang)

(module ratchet racket
  
  (require ratchet
           (submod "./farm-lang.rkt" farm-stuff)
           "../icons.rkt"
           (prefix-in s: survival)
           (prefix-in h: 2htdp/image))

  (define (crop i)
    (h:crop 0 0 32 32 i))

  (define-visual-language farm-lang
    (submod "./farm-lang.rkt" farm-stuff)
    [cat           c (crop s:CAT-SHEET)]

    [start-a         s play-icon]))



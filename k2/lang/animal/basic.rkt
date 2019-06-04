#lang racket

(provide (all-from-out "./animal-lang.rkt"))
(require "./animal-lang.rkt")

(module reader syntax/module-reader
  k2/lang/animal/animal-lang)

(module ratchet racket 
  (require ratchet
           "./animal-lang.rkt"
           "../animal/animal-asset-friendly-names.rkt"
           "../icons.rkt"
           (prefix-in s: survival)
           (prefix-in h: 2htdp/image))

  (define (crop i)
    (h:crop 0 0 32 32 i))

  (define-visual-language #:wrapper launch-for-ratchet
                          animal-lang
                          "./animal-lang.rkt"
                          [cat     c (crop s:CAT-SHEET)]

                          [start-animal   s play-icon]))



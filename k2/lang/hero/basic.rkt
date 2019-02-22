#lang racket

;This allows the lang to be used as a module:
;  (require k2/lang/ocean/fish)
(provide (all-from-out "./hero-lang.rkt"))
(require "./hero-lang.rkt")

;This allows the lang to be used as a lang
;  #lang k2/lang/hero/fish
(module reader syntax/module-reader
  k2/lang/hero/hero-lang)

;This allows the lang to be used from Ratchet
;  #lang k2/lang/hero/fish
;  ... Then press "Ratchet"
(module ratchet racket
  
  (require ratchet
           (submod "./hero-lang.rkt" hero-stuff)
           "../icons.rkt"
           (prefix-in a: battle-arena-avengers/assets)
           (prefix-in h: 2htdp/image)
           (prefix-in p: pict)
           (prefix-in p: pict/flash))

  (define (crop i)
    (h:crop 0 0 32 32 i))

  (define-visual-language fish-lang
    (submod "./hero-lang.rkt" hero-stuff)
    [blackwidow     b (crop a:blackwidow)]   
    [gamora         g (crop a:gamora)]
    [captainamerica c (crop a:captainamerica)]
    [drax           d (crop a:drax)]
    [hawkeye        h (crop a:hawkeye)]
    [hulk           u (crop a:hulk)]
    [ironman        i (crop a:ironman)]
    [loki           l (crop a:loki)]

    [start         s play-icon]))



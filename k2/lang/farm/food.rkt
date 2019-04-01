#lang racket

(provide (all-from-out "./farm-lang.rkt"))
(require "./farm-lang.rkt")

(module reader syntax/module-reader
  k2/lang/farm/farm-lang)

(module ratchet racket
  
  (require ratchet
           (submod "./farm-lang.rkt" farm-stuff)
           "../icons.rkt"
           ;"farm-assets.rkt"
           (prefix-in s: survival)
           (prefix-in h: 2htdp/image))

  (define (crop i)
    (h:crop 0 0 32 32 i))

  (define (crop-left i)
    (define w (h:image-width i))
    (define h (h:image-height i))
    (h:crop (- w 32) 0 w 32 i))
  
  (define-visual-language farm-lang
    (submod "./farm-lang.rkt" farm-stuff)
    [start-a  s play-icon]
    ;[cat c (crop s:CAT-SHEET)]
    [chicken  c (crop (s:render chicken))]
    [llama    l (crop (crop-left (s:render llama)))]
    [horse    h (crop (crop-left (s:render horse)))]
    [rabbit   r (crop (s:render rabbit))]
    
    [apple    a (crop (s:render apple))]
    [brocolli b (crop (s:render brocolli))]
    [grapes   g (crop (s:render grapes))]
    [onion    o (crop (s:render onion))]
    [potato   p (crop (s:render potato))]
    [tomato   t (crop (s:render tomato))]
))



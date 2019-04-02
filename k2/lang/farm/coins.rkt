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
    [start-b  x play-icon]
    
    [llama    l (crop (crop-left (s:render llama)))]
    [cow      c (crop (crop-left (s:render cow)))]
    [rabbit   r (crop (s:render rabbit))]
    [sheep    s (crop (crop-left (s:render sheep)))]
    
    [apple    a (crop (s:render apple))]
    [banana   b (crop (s:render banana))]
    [potato   p (crop (s:render potato))]
    [kiwi     k (crop (s:render kiwi))]

    [copper   1 (crop (s:render copper))]
    [silver   2 (crop (s:render silver))]
    [gold     3 (crop (s:render gold))]
))



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
    [start-c  x play-icon]
    
    [llama    l (crop (crop-left (s:render llama)))]
    [horse    h (crop (crop-left (s:render horse)))]
    [cow      c (crop (crop-left (s:render cow)))]
    [rabbit   r (crop (s:render rabbit))]
    [sheep    s (crop (crop-left (s:render sheep)))]
    [dog      d (crop (crop-left (s:render dog)))]
    [wolf     w (crop (crop-left (s:render wolf)))]
    
    [apple    a (crop (s:render apple))]
    [grapes   g (crop (s:render grapes))]
    [kiwi     k (crop (s:render kiwi))]
    [pepper   p (crop (s:render pepper))]

    [copper   1 (crop (s:render copper))]
    [silver   2 (crop (s:render silver))]
    [gold     3 (crop (s:render gold))]
))



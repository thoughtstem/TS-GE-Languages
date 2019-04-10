#lang racket

(provide (all-from-out "../animal/animal-lang.rkt")
         (all-from-out "../animal/animal-asset-friendly-names.rkt"  ))

(require "../animal/animal-lang.rkt"
         "../animal/animal-asset-friendly-names.rkt")

(module reader syntax/module-reader
  k2/lang/animal/animal-lang)

(module ratchet racket
  
  (require ratchet
           (rename-in "../animal/animal-lang.rkt" 
	              [start-a start])
           "../icons.rkt"
           "../animal/animal-asset-friendly-names.rkt"
           (prefix-in s: survival)
           (prefix-in h: 2htdp/image))

  (define (crop i)
    (h:crop 0 0 32 32 i))

  (define (crop-left i)
    (define w (h:image-width i))
    (define h (h:image-height i))
    (h:crop (- w 32) 0 w 32 i))
  
  (define-visual-language zoo-lang
    "../animal/animal-lang.rkt" 
    [start  s play-icon]

    [zookeeper     z (s:scale-to-fit (s:draw-sprite zookeeper) 32)]
    ;[lion          l (s:scale-to-fit (s:draw-sprite lion) 32)]
    [monkey        m (s:scale-to-fit (s:draw-sprite monkey) 32)]
    ;[tiger         t (s:scale-to-fit (s:draw-sprite tiger) 32)]
    [elephant      e (s:scale-to-fit (s:draw-sprite elephant) 32)]
    ;[giraffe       g (s:scale-to-fit (s:draw-sprite giraffe) 32)]
    [hippo         h (s:scale-to-fit (s:draw-sprite hippo) 32)]
    [kangaroo      k (s:scale-to-fit (s:draw-sprite kangaroo) 32)]
    ;[penguin       p (s:scale-to-fit (s:draw-sprite penguin) 32)]
    
    [apple    a (crop (s:render apple))]
    [brocolli b (crop (s:render brocolli))]
    [grapes   g (crop (s:render grapes))]
    [onion    o (crop (s:render onion))]
    [potato   p (crop (s:render potato))]
    [tomato   t (crop (s:render tomato))]))



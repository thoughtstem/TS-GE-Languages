#lang racket

(provide (all-from-out "../animal/animal-lang.rkt")
         (all-from-out "../animal/animal-asset-friendly-names.rkt"  ))

(require "../animal/animal-lang.rkt"
         "../animal/animal-asset-friendly-names.rkt")

(module reader syntax/module-reader
  k2/lang/farm/farm-food-lang)

(module ratchet racket
  
  (require ratchet
           (rename-in "../animal/animal-lang.rkt" 
	              [start-a start])
           "../icons.rkt"
           "../animal/animal-asset-friendly-names.rkt"
           (prefix-in s: survival)
           (prefix-in h: 2htdp/image))

  (define l (list apple broccoli grapes onion potato tomato))
  
  (define rand
    (list-ref l (random 0 6)))
  
  (define-visual-language farm-lang
    "../animal/animal-lang.rkt" 
    [start    x play-icon]

    [chicken  c (s:scale-to-fit (s:draw-sprite chicken)  32)]
    [llama    l (s:scale-to-fit (s:draw-sprite llama)    32)]
    [horse    h (s:scale-to-fit (s:draw-sprite horse)    32)]
    [rabbit   r (s:scale-to-fit (s:draw-sprite rabbit)   32)]
    
    [apple    a (s:scale-to-fit (s:draw-sprite apple)    32)]
    [broccoli b (s:scale-to-fit (s:draw-sprite broccoli) 32)]
    [grapes   g (s:scale-to-fit (s:draw-sprite grapes)   32)]
    [onion    o (s:scale-to-fit (s:draw-sprite onion)    32)]
    [potato   p (s:scale-to-fit (s:draw-sprite potato)   32)]
    [tomato   t (s:scale-to-fit (s:draw-sprite tomato)   32)]

    [rand     ? question-icon]

    ))
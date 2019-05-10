#lang racket

(provide (all-from-out "../animal/animal-lang.rkt"
                       "../animal/animal-asset-friendly-names.rkt")
         (rename-out [start-animal start])
         rand) 

(require "../animal/animal-lang.rkt"
         "../animal/animal-asset-friendly-names.rkt")

(define rand
  (lambda () (first (shuffle (list apple banana grapes onion potato tomato)))))

(module reader syntax/module-reader
  k2/lang/zoo/foods
  )
  


(module ratchet racket
  
  (require ratchet
           (rename-in "../animal/animal-lang.rkt" 
	              [start-animal start])
           "../icons.rkt"
           "../animal/animal-asset-friendly-names.rkt"
           (prefix-in s: survival)
           (prefix-in h: 2htdp/image))

  (define rand
    (lambda () (first (shuffle (list apple banana grapes onion potato tomato)))))

  (define (crop i)
    (h:crop 0 0 32 32 i))

  (define (fit i)
    (s:scale-to-fit i 32))

  (define (crop-left i)
    (define w (h:image-width i))
    (define h (h:image-height i))
    (h:crop (- w 32) 0 w 32 i))
  
  (define-visual-language zoo-lang
    "../animal/animal-lang.rkt" 
    [start  s play-icon]
    
    [monkey        m (fit (s:draw-sprite monkey))]
    [elephant      e (fit (s:draw-sprite elephant))]
    [hippo         h (fit (s:draw-sprite hippo))]
    [kangaroo      k (fit (s:draw-sprite kangaroo))]
    
    [apple    a (fit (s:draw-sprite apple))]
    [banana   b (fit (s:draw-sprite banana))]
    [fish     f (fit (s:draw-sprite fish))]
    [grapes   g (fit (s:draw-sprite grapes))]
    [onion    o (fit (s:draw-sprite onion))]
    [potato   p (fit (s:draw-sprite potato))]
    [tomato   t (fit (s:draw-sprite tomato))]

    [rand     ? question-icon]
    
    [red            R (h:square 32 'solid 'red)]
    [orange         O (h:square 32 'solid 'orange)]
    [yellow         Y (h:square 32 'solid 'yellow)]
    [green          G (h:square 32 'solid 'green)]
    [blue           B (h:square 32 'solid 'blue)]
    [purple         P (h:square 32 'solid 'purple)]

    
    ))



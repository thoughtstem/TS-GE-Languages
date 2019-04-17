#lang racket

(provide (all-from-out "../animal/animal-lang.rkt"
                       "../animal/animal-asset-friendly-names.rkt")
         (rename-out [start-b start])
         rand) 

(require "../animal/animal-lang.rkt"
         "../animal/animal-asset-friendly-names.rkt")

(define rand
  (lambda ()
    (first (shuffle (list zookeeper monkey elephant giraffe
                          hippo kangaroo penguin apple banana
                          copper silver gold)))))

(module reader syntax/module-reader
  k2/lang/zoo/coins
  )

(module ratchet racket

  (require ratchet
           (rename-in "../animal/animal-lang.rkt" 
                      (start-b start))
           "../icons.rkt"
           "../animal/animal-asset-friendly-names.rkt"
           (prefix-in s: survival)
           (prefix-in h: 2htdp/image))

  (define rand
    (lambda () (first (shuffle (list zookeeper monkey elephant giraffe
                                     hippo kangaroo penguin apple banana
                                     copper silver gold)))))

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
    [start    x play-icon]
    
    [zookeeper     z (fit (s:draw-sprite zookeeper))]
    [monkey        m (fit (s:draw-sprite monkey))]
    [elephant      e (fit (s:draw-sprite elephant))]
    [giraffe       g (fit (s:draw-sprite giraffe))]
    [hippo         h (fit (s:draw-sprite hippo))]
    [kangaroo      k (fit (s:draw-sprite kangaroo))]
    [penguin       p (fit (s:draw-sprite penguin))]
    
    [apple    a (fit (s:draw-sprite apple))]
    [banana   b (fit (s:draw-sprite banana))]
    ;[potato   p (fit (s:draw-sprite potato))]
    ;[kiwi     k (fit (s:draw-sprite kiwi))]

    [copper   1 (fit (s:draw-sprite copper))]
    [silver   2 (fit (s:draw-sprite silver))]
    [gold     3 (fit (s:draw-sprite gold))]

    [rand     ? question-icon]
    ))



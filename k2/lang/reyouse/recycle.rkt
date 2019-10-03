#lang racket

(provide (all-from-out "../animal/animal-lang.rkt"
                       "../animal/animal-asset-friendly-names.rkt")
         (rename-out [start-recycle start])
         rand
         )

(require "../animal/animal-lang.rkt"
         "../animal/animal-asset-friendly-names.rkt")

(define rand
  (lambda () (first (shuffle (list trash can bottle)))))

(module reader syntax/module-reader
  k2/lang/reyouse/recycle)

(module ratchet racket  
  (require ratchet
           ratchet/util
           (rename-in "../animal/animal-lang.rkt" 
	              [start-recycle start])
           "../icons.rkt"
           "../animal/animal-asset-friendly-names.rkt"
           (prefix-in s: survival))

  (define rand
    (lambda () (first (shuffle (list trash can bottle)))))

  (define (fit i)
    (s:scale-to-fit i 32))
  
  (define-visual-language #:wrapper launch-for-ratchet
                          reyouse-lang "../animal/animal-lang.rkt" 
    [start      = play-icon]
    
    [zookeeper  z (fit (s:draw-sprite zookeeper))]

    [apple      a (fit (s:draw-sprite apple))]
    [potato     p (fit (s:draw-sprite potato))]
    [onion      o (fit (s:draw-sprite onion))]
    [strawberry s (fit (s:draw-sprite strawberry))]
        
    [trash      t (fit (s:draw-sprite trash))]
    [bottle     b (fit (s:draw-sprite bottle))]
    [can        c (fit (s:draw-sprite can))] 

    [monkey     m (fit (s:draw-sprite monkey))]
    [elephant   e (fit (s:draw-sprite elephant))]
    [giraffe    g (fit (s:draw-sprite giraffe))]
    [hippo      h (fit (s:draw-sprite hippo))]
    [kangaroo   k (fit (s:draw-sprite kangaroo))]

    [rand       ? question-icon]

                          ))

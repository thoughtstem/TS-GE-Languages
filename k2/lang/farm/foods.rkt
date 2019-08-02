#lang racket

(provide (all-from-out "../animal/animal-lang.rkt"
                       "../animal/animal-asset-friendly-names.rkt")
         (rename-out [start-animal start])
         rand
         )

(require "../animal/animal-lang.rkt"
         "../animal/animal-asset-friendly-names.rkt")

(define rand
  (lambda () (first (shuffle (list apple broccoli grapes onion potato tomato)))))

(module reader syntax/module-reader
  k2/lang/farm/foods)

(module ratchet racket  
  (require ratchet
           ratchet/util
           (rename-in "../animal/animal-lang.rkt" 
	              [start-animal start])
           "../icons.rkt"
           "../animal/animal-asset-friendly-names.rkt"
           (prefix-in s: survival))

  (define rand
    (lambda () (first (shuffle (list apple broccoli grapes onion potato tomato)))))
  
  (define-visual-language #:wrapper launch-for-ratchet
                          farm-lang
                          "../animal/animal-lang.rkt" 
                          [start    = play-icon]

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

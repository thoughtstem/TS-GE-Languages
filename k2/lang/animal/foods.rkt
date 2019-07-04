#lang racket

(provide (all-from-out "./animal-lang.rkt"
                       "../animal/animal-asset-friendly-names.rkt")
         (rename-out [start-animal start])
         rand
         )

(require "./animal-lang.rkt"
         "../animal/animal-asset-friendly-names.rkt")
(module reader syntax/module-reader
  k2/lang/animal/animal-lang)

(define rand
    (lambda () (first (shuffle (list cat dog apple mushroom onion potato)))))


(module ratchet racket 
  (require ratchet
           ratchet/util
           (rename-in "../animal/animal-lang.rkt" 
	              [start-animal start])
           "../icons.rkt"
           "../animal/animal-asset-friendly-names.rkt"
           (prefix-in s: survival))

  (define rand
    (lambda () (first (shuffle (list cat dog apple mushroom onion potato)))))

  (define-visual-language #:wrapper launch-for-ratchet
                          animal-lang
                          "./animal-lang.rkt"
                          ;Animals
                          [cat      c (s:scale-to-fit (s:draw-sprite cat)      32)]
                          [dog      d (s:scale-to-fit (s:draw-sprite dog)      32)]
                          ;[horse    h (s:scale-to-fit (s:draw-sprite horse)    32)]
                          ;[rabbit   r (s:scale-to-fit (s:draw-sprite rabbit)   32)]
                          ;[turkey   t (s:scale-to-fit (s:draw-sprite turkey)   32)]
                          ;[wolf     w (s:scale-to-fit (s:draw-sprite wolf)     32)]

                          ;Foods
                          [apple    a (s:scale-to-fit (s:draw-sprite apple)    32)]
                          [mushroom m (s:scale-to-fit (s:draw-sprite mushroom) 32)]
                          [onion    o (s:scale-to-fit (s:draw-sprite onion)    32)]
                          [potato   p (s:scale-to-fit (s:draw-sprite potato)   32)]

                          ;Coins
                          ;[copper   x (s:scale-to-fit (s:draw-sprite copper)   32)]
                          ;[silver   y (s:scale-to-fit (s:draw-sprite silver)   32)]
                          ;[gold     z (s:scale-to-fit (s:draw-sprite gold)     32)]
                          
                          ;Other
                          [rand     ? question-icon]
                          [start    = play-icon]))



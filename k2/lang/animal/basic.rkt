#lang racket

(provide (all-from-out "./animal-lang.rkt")
         rand)
(require "./animal-lang.rkt")

 (define rand
    (lambda () (first (shuffle (list dog horse rabbit apple grapes mushroom onion potato strawberry)))))


(module reader syntax/module-reader
  k2/lang/animal/animal-lang)

(module ratchet racket 
  (require ratchet
           ratchet/util
           "./animal-lang.rkt"
           "../animal/animal-asset-friendly-names.rkt"
           "../icons.rkt"
           (prefix-in s: survival)
           (prefix-in h: 2htdp/image))

  (define (crop i)
    (h:crop 0 0 32 32 i))

  (define rand
    (lambda () (first (shuffle (list dog horse rabbit apple grapes mushroom onion potato strawberry)))))

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
                          ;[gold     g (s:scale-to-fit (s:draw-sprite gold)     32)]
                          ;[silver   s (s:scale-to-fit (s:draw-sprite silver)   32)]
                          ;[copper   c (s:scale-to-fit (s:draw-sprite copper)   32)]

                          ;Other
                          [rand     ? question-icon]
                          [start-animal   = play-icon]))



#lang racket

(provide (all-from-out "./whack-a-sprite-lang.rkt"
                       "./asset-friendly-names.rkt")
         (rename-out [start-whack-a-sprite start])
         rand
         )

(require "./whack-a-sprite-lang.rkt"
         "./asset-friendly-names.rkt")

(define rand
  (lambda () (first (shuffle (list cat dog horse rabbit
                                   apple kiwi onion potato tomato)))))


(module reader syntax/module-reader
  k2/lang/whack-a-sprite/collect)

 
(module ratchet racket 
(require ratchet
           ratchet/util
           (rename-in "./whack-a-sprite-lang.rkt" 
	              [start-whack-a-sprite start])
           "../icons.rkt"
           "./asset-friendly-names.rkt"
           (prefix-in s: survival))

  (define rand
    (lambda () (first (shuffle (list cat dog horse rabbit
                                     apple kiwi onion potato tomato)))))

  (define-visual-language #:wrapper launch-for-ratchet
    whack-a-sprite-lang
    "./whack-a-sprite-lang.rkt" 
    
    [start    = play-icon]

    ;Pointers
    [pointer  p (s:scale-to-fit (s:draw-sprite pointer) 32)]
    [cage     c (s:scale-to-fit (s:draw-sprite cage) 32)]
    ;Animals
    ;[cat      c (s:scale-to-fit (s:draw-sprite cat)      32)]
    [dog      d (s:scale-to-fit (s:draw-sprite dog)      32)]
    ;[goat     g (s:scale-to-fit (s:draw-sprite goat)     32)]
    [horse    h (s:scale-to-fit (s:draw-sprite horse)    32)]
    [rabbit   r (s:scale-to-fit (s:draw-sprite rabbit)   32)]
    ;[sheep    s (s:scale-to-fit (s:draw-sprite sheep)    32)]
    ;[turkey   t (s:scale-to-fit (s:draw-sprite turkey)   32)]
    ;[wolf     w (s:scale-to-fit (s:draw-sprite wolf)     32)]

    ;Foods
    [apple      a (s:scale-to-fit (s:draw-sprite apple)      32)]
    ;[banana     b (s:scale-to-fit (s:draw-sprite banana)     32)]
    ;[eggplant   e (s:scale-to-fit (s:draw-sprite eggplant)   32)]
    [kiwi       k (s:scale-to-fit (s:draw-sprite kiwi)       32)]
    ;[mushroom   m (s:scale-to-fit (s:draw-sprite mushroom)   32)]
    [onion      o (s:scale-to-fit (s:draw-sprite onion)      32)]
    ;[potato     p (s:scale-to-fit (s:draw-sprite potato)     32)]
    ;[strawberry s (s:scale-to-fit (s:draw-sprite strawberry) 32)]
    [tomato     t (s:scale-to-fit (s:draw-sprite tomato)     32)]

    ;Other
    [rand     ? question-icon]))



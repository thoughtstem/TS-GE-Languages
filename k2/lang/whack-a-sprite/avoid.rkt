#lang racket

(provide (all-from-out "./whack-a-sprite-lang.rkt"
                       "./asset-friendly-names.rkt")
         (rename-out [start-whack-a-sprite start])
         rand
         )

(require "./whack-a-sprite-lang.rkt"
         "./asset-friendly-names.rkt")

(module reader syntax/module-reader
  k2/lang/whack-a-sprite/avoid)

(define rand
  (lambda () (first (shuffle (list cat dog goat horse rabbit sheep turkey wolf
                                   apple banana kiwi mushroom onion pepper)))))

(module ratchet racket 
  (require ratchet
           ratchet/util
           (rename-in "./whack-a-sprite-lang.rkt" 
                      [start-whack-a-sprite start])
           "../icons.rkt"
           "./asset-friendly-names.rkt"
           (prefix-in s: survival)
           (prefix-in h: 2htdp/image))

  (define (crop i)
    (h:crop 0 0 0 32 32 i))

  (define rand
    (lambda () (first (shuffle (list cat dog goat horse rabbit sheep turkey wolf
                                     apple banana kiwi mushroom onion pepper)))))

  (define-visual-language #:wrapper launch-for-ratchet
    whack-a-sprite-lang
    "./whack-a-sprite-lang.rkt"
    
    [start    = play-icon]

    ;Pointers
    [pointer    p (s:scale-to-fit (s:draw-sprite pointer) 32)]
    [cage       c (s:scale-to-fit (s:draw-sprite cage) 32)]
    [magic-wand m (s:scale-to-fit (s:draw-sprite magic-wand) 32)]
    [glove      g (s:scale-to-fit (s:draw-sprite glove) 32)]
    [white-hand w (s:scale-to-fit (s:draw-sprite white-hand) 32)]
    
    ;Animals
    ;[cat      c (s:scale-to-fit (s:draw-sprite cat)      32)]
    [dog      d (s:scale-to-fit (s:draw-sprite dog)      32)]
    ;[goat     g (s:scale-to-fit (s:draw-sprite goat)     32)]
    [horse    h (s:scale-to-fit (s:draw-sprite horse)    32)]
    [rabbit   r (s:scale-to-fit (s:draw-sprite rabbit)   32)]
    [sheep    s (s:scale-to-fit (s:draw-sprite sheep)    32)]
    [turkey   t (s:scale-to-fit (s:draw-sprite turkey)   32)]
    ;[wolf     w (s:scale-to-fit (s:draw-sprite wolf)     32)]
    
    ;Foods
    [apple    a (s:scale-to-fit (s:draw-sprite apple)    32)]
    [banana   b (s:scale-to-fit (s:draw-sprite banana)   32)]
    [kiwi     k (s:scale-to-fit (s:draw-sprite kiwi)     32)]
    [mushroom m (s:scale-to-fit (s:draw-sprite mushroom) 32)]
    [onion    o (s:scale-to-fit (s:draw-sprite onion)    32)]
    ;[pepper   p (s:scale-to-fit (s:draw-sprite pepper)   32)]
                          
    ;Colors
    [red            R (h:square 32 'solid 'red)]
    [orange         O (h:square 32 'solid 'orange)]
    [yellow         Y (h:square 32 'solid 'yellow)]
    [green          G (h:square 32 'solid 'green)]
    [blue           B (h:square 32 'solid 'blue)]
    [purple         P (h:square 32 'solid 'purple)]
    
    ;Other
    [rand     ? question-icon]))




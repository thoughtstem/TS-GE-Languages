#lang racket
#|
(provide (all-from-out "./animal-lang.rkt"
                       "../animal/animal-asset-friendly-names.rkt")
         (rename-out [start-animal-asp start])
         rand
         )
(require "./animal-lang.rkt"
         "../animal/animal-asset-friendly-names.rkt")

(module reader syntax/module-reader
  k2/lang/animal/friends)

  (define rand
    (lambda () (first (shuffle (list cat dog goat horse rabbit sheep turkey
                                     apple broccoli kiwi mushroom onion potato)))))
(module ratchet racket 
  (require ratchet
           ratchet/util
           (rename-in "../animal/animal-lang.rkt" 
	              [start-animal-asp start])
           "../icons.rkt"
           "../animal/animal-asset-friendly-names.rkt"
           (prefix-in s: survival)
           (prefix-in h: 2htdp/image))

  (define (crop i)
    (h:crop 0 0 0 32 32 i))
  
  (define rand
    (lambda () (first (shuffle (list cat dog goat horse rabbit sheep turkey
                                     apple broccoli kiwi mushroom onion potato)))))

  (define-visual-language #:wrapper launch-for-ratchet
    animal-lang
    "./animal-lang.rkt"

    [start    = play-icon]
    
    ;Animals
    [cat      c (s:scale-to-fit (s:draw-sprite cat)      32)]
    [dog      d (s:scale-to-fit (s:draw-sprite dog)      32)]
    [goat     g (s:scale-to-fit (s:draw-sprite goat)     32)]
    [horse    h (s:scale-to-fit (s:draw-sprite horse)    32)]
    [rabbit   r (s:scale-to-fit (s:draw-sprite rabbit)   32)]
    [sheep    s (s:scale-to-fit (s:draw-sprite sheep)    32)]
    [turkey   t (s:scale-to-fit (s:draw-sprite turkey)   32)]
    ;[wolf     w (s:scale-to-fit (s:draw-sprite wolf)     32)]

    ;Foods
    [apple     a (s:scale-to-fit (s:draw-sprite apple)     32)]
    [broccoli  b (s:scale-to-fit (s:draw-sprite broccoli)  32)]
    ;[grapes    g (s:scale-to-fit (s:draw-sprite grapes)    32)]
    [kiwi      k (s:scale-to-fit (s:draw-sprite kiwi)      32)]
    [mushroom  m (s:scale-to-fit (s:draw-sprite mushroom)  32)]
    [onion     o (s:scale-to-fit (s:draw-sprite onion)     32)]
    [potato    p (s:scale-to-fit (s:draw-sprite potato)    32)]
                          
    ;Colors
    [red            R (h:square 32 'solid 'red)]
    [orange         O (h:square 32 'solid 'orange)]
    [yellow         Y (h:square 32 'solid 'yellow)]
    [green          G (h:square 32 'solid 'green)]
    [blue           B (h:square 32 'solid 'blue)]
    [purple         P (h:square 32 'solid 'purple)]
    
    ;Other
    [rand     ? question-icon]))


|#
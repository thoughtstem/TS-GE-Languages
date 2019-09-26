#lang racket

(provide (all-from-out "./clicker-lang.rkt"
                       "./asset-friendly-names.rkt")
         (rename-out [start-clicker-forest start-forest]
                     [start-clicker-desert start-desert]
                     [start-clicker-snow start-snow]
                     [start-clicker-lava start-lava]
                     [start-clicker-pink start-pink])
         rand
         )

(require "./clicker-lang.rkt"
         "./asset-friendly-names.rkt")

(define rand
  (lambda () (first (shuffle (list cat dog horse rabbit
                                   apple kiwi onion potato tomato)))))


(module reader syntax/module-reader
  k2/lang/clicker/collect)

 
(module ratchet racket 
(require ratchet
           ratchet/util
           (rename-in "./clicker-lang.rkt" 
	              [start-clicker-forest start-forest]
                      [start-clicker-desert start-desert]
                      [start-clicker-snow   start-snow]
                      [start-clicker-lava   start-lava]
                      [start-clicker-pink   start-pink])
           "../icons.rkt"
           "./asset-friendly-names.rkt"
           (prefix-in s: survival)
           (prefix-in h: 2htdp/image)
           (prefix-in p: pict))

  (define rand
    (lambda () (first (shuffle (list cat dog horse rabbit
                                     apple kiwi onion potato tomato)))))

  (define-visual-language #:wrapper launch-for-ratchet
    clicker-lang
    "./clicker-lang.rkt" 
    
    [start-forest F (h:overlay (p:pict->bitmap play-icon) (h:crop 0 0 32 32 s:FOREST-BG))]
    [start-desert D (h:overlay (p:pict->bitmap play-icon) (h:crop 0 0 32 32 s:DESERT-BG))]
    [start-snow S (h:overlay (p:pict->bitmap play-icon) (h:crop 0 0 32 32 s:SNOW-BG))]
    [start-lava L (h:overlay (p:pict->bitmap play-icon) (h:crop 0 0 32 32 s:LAVA-BG))]
    [start-pink P (h:overlay (p:pict->bitmap play-icon) (h:crop 0 0 32 32 s:PINK-BG))]

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
    ;[sheep    s (s:scale-to-fit (s:draw-sprite sheep)    32)]
    ;[turkey   t (s:scale-to-fit (s:draw-sprite turkey)   32)]
    ;[wolf     w (s:scale-to-fit (s:draw-sprite wolf)     32)]

    ;Foods
    [apple      a (s:scale-to-fit (s:draw-sprite apple)      32)]
    [kiwi       k (s:scale-to-fit (s:draw-sprite kiwi)       32)]

    ;Specials
    [freeze    f (s:scale-to-fit (s:draw-sprite freeze) 32)]
    [slow      s (s:scale-to-fit (s:draw-sprite slow) 32)]
    [light     l (s:scale-to-fit (s:draw-sprite light) 32)]

    ;Other
    [rand     ? question-icon]))



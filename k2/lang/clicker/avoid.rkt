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

(module reader syntax/module-reader
  k2/lang/clicker/avoid)

(define rand
  (lambda () (first (shuffle (list cat dog goat horse rabbit sheep turkey wolf
                                   apple banana kiwi mushroom onion pepper)))))

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

  (define (crop i)
    (h:crop 0 0 32 32 i))

  (define rand
    (lambda () (first (shuffle (list cat dog goat horse rabbit sheep turkey wolf
                                     apple banana kiwi mushroom onion pepper)))))

  (define (bg->play-icon bg)
    (h:overlay play-outline-icon ((compose (curry s:change-img-bright 40)
                                           (curry s:change-img-sat -20))
                                  (h:crop 624 420 32 24 bg))))

  (define-visual-language #:wrapper launch-for-ratchet
    clicker-lang
    "./clicker-lang.rkt"
    
    [start-forest F (h:overlay (p:pict->bitmap play-outline-icon) (bg->play-icon s:FOREST-BG))]
    [start-desert D (h:overlay (p:pict->bitmap play-outline-icon) (bg->play-icon s:DESERT-BG))]
    [start-snow S (h:overlay (p:pict->bitmap play-outline-icon)   (bg->play-icon s:SNOW-BG))]
    [start-lava L (h:overlay (p:pict->bitmap play-outline-icon)   (bg->play-icon s:LAVA-BG))]
    ;[start-pink P (h:overlay (p:pict->bitmap play-outline-icon)   (bg->play-icon s:PINK-BG))]

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
    [turkey   t (s:scale-to-fit (s:draw-sprite turkey)   32)]
    ;[wolf     w (s:scale-to-fit (s:draw-sprite wolf)     32)]
    
    ;Foods
    [apple    a (s:scale-to-fit (s:draw-sprite apple)    32)]
    [banana   b (s:scale-to-fit (s:draw-sprite banana)   32)]
    [kiwi     k (s:scale-to-fit (s:draw-sprite kiwi)     32)]

    ;Specials
    [freeze    f (s:scale-to-fit (s:draw-sprite freeze) 32)]
    [slow      s (s:scale-to-fit (s:draw-sprite slow) 32)]
    [light     l (s:scale-to-fit (s:draw-sprite light) 32)]
    
    ;Colors
    [red            R (h:square 32 'solid 'red)]
    [orange         O (h:square 32 'solid 'orange)]
    [yellow         Y (h:square 32 'solid 'yellow)]
    [green          G (h:square 32 'solid 'green)]
    [blue           B (h:square 32 'solid 'blue)]
    [purple         P (h:square 32 'solid 'purple)]
    
    ;Other
    [rand     ? question-icon]))




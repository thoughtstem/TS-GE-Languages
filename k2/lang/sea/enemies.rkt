#lang racket


(provide (all-from-out "../animal/animal-lang.rkt")
         (all-from-out "../animal/animal-asset-friendly-names.rkt"  ))

(require "../animal/animal-lang.rkt"
         "../animal/animal-asset-friendly-names.rkt")

(module reader syntax/module-reader
  k2/lang/sea/sea-enemies-lang)

(module ratchet racket
  
  (require ratchet
           (rename-in "../animal/animal-lang.rkt" 
	              [start-sea-c start])
           "../icons.rkt"
           "../animal/animal-asset-friendly-names.rkt"
           (prefix-in s: survival)
           (prefix-in h: 2htdp/image))

  (define l
    (list shark ghost-fish red-fish orange-fish jellyfish octopus crab
          potato strawberry apple cherries
          copper silver gold))

  (define rand
    (list-ref l (random 0 6)))

  (define-visual-language sea-lang
    "../animal/animal-lang.rkt"

    [start       x play-icon]

    [shark       s (s:scale-to-fit (s:draw-sprite shark)       32)]
    [ghost-fish  g (s:scale-to-fit (s:draw-sprite ghost-fish)  32)]
    [red-fish    r (s:scale-to-fit (s:draw-sprite red-fish)    32)]
    [orange-fish f (s:scale-to-fit (s:draw-sprite orange-fish) 32)]
    [jellyfish   j (s:scale-to-fit (s:draw-sprite jellyfish)   32)]
    [octopus     o (s:scale-to-fit (s:draw-sprite octopus)     32)]
    [crab        c (s:scale-to-fit (s:draw-sprite crab)        32)]
    
    [potato      p (s:scale-to-fit (s:draw-sprite potato)      32)]
    [strawberry  b (s:scale-to-fit (s:draw-sprite strawberry)  32)]
    [apple       a (s:scale-to-fit (s:draw-sprite apple)       32)]
    [cherries    i (s:scale-to-fit (s:draw-sprite cherries)    32)]

    [copper      1 (s:scale-to-fit (s:draw-sprite copper)      32)]
    [silver      2 (s:scale-to-fit (s:draw-sprite silver)      32)]
    [gold        3 (s:scale-to-fit (s:draw-sprite gold)        32)]

    [rand     ? question-icon]
    ))





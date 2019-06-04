#lang racket


(provide (all-from-out "../animal/animal-lang.rkt")
         (all-from-out "../animal/animal-asset-friendly-names.rkt"  )
         (rename-out [start-sea start])
         rand)

(require "../animal/animal-lang.rkt"
         "../animal/animal-asset-friendly-names.rkt")

(module reader syntax/module-reader
  k2/lang/sea/enemies)

(define rand
  (lambda () (first (shuffle (list shark ghost-fish red-fish orange-fish jellyfish octopus crab
                                   potato strawberry apple cherries))))) 


(module ratchet racket
  
  (require ratchet
           ratchet/util
           (rename-in "../animal/animal-lang.rkt" 
	              [start-sea start])
           "../icons.rkt"
           "../animal/animal-asset-friendly-names.rkt"
           (prefix-in s: survival)
           (prefix-in h: 2htdp/image))

  (define rand
    (lambda () (first (shuffle (list shark ghost-fish red-fish orange-fish jellyfish octopus crab
                                     potato strawberry apple cherries))))) 

  (define-visual-language #:wrapper launch-for-ratchet
                          sea-lang
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
                          [banana      b (s:scale-to-fit (s:draw-sprite banana)      32)]
                          [kiwi        k (s:scale-to-fit (s:draw-sprite kiwi)        32)]
                          [tomato      t (s:scale-to-fit (s:draw-sprite tomato)      32)]
                          [mushroom    m (s:scale-to-fit (s:draw-sprite mushroom)    32)]

                          [red    R (h:square 32 'solid 'red)]
                          [orange O (h:square 32 'solid 'orange)]
                          [yellow Y (h:square 32 'solid 'yellow)]
                          [green  G (h:square 32 'solid 'green)]
                          [blue   B (h:square 32 'solid 'blue)]
                          [purple P (h:square 32 'solid 'purple)]


                          [rand        ? question-icon]
                          ))





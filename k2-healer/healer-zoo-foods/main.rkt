#lang racket

(require ratchet)

(define-ratchet-lang 
  (provide 
    (all-from-out racket) 
    (all-from-out healer-zoo-lib)
    (all-from-out animal-assets))

  (require racket 
           animal-assets 
           healer-zoo-lib 
           (only-in 2htdp/image square))

  #:wrapper launch-game-engine

    [start  s play-icon]
    
    [monkey        m (draw-sprite monkey)]
    [elephant      e (draw-sprite elephant)]
    [hippo         h (draw-sprite hippo)]
    [kangaroo      k (draw-sprite kangaroo)]
    
    [apple    a (draw-sprite apple)]
    [banana   b (draw-sprite banana)]
    [fish     f (draw-sprite fish)]
    [grapes   g (draw-sprite grapes)]
    [onion    o (draw-sprite onion)]
    [potato   p (draw-sprite potato)]
    [tomato   t (draw-sprite tomato)]

    [rand     ? question-icon])

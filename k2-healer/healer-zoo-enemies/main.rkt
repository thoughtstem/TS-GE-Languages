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

  [start    x play-icon]

  [zookeeper     z (draw-sprite zookeeper)]
  [monkey        m (draw-sprite monkey)]
  [elephant      e (draw-sprite elephant)]
  [hippo         h (draw-sprite hippo)]
  [kangaroo      k (draw-sprite kangaroo)]
  [penguin       p (draw-sprite penguin)]

  [apple    a (draw-sprite apple)]
  [banana   b (draw-sprite banana)]
  [fish     f (draw-sprite fish)]
  [tomato   t (draw-sprite tomato)]

  [copper   c (draw-sprite copper)]
  [silver   s (draw-sprite silver)]
  [gold     g (draw-sprite gold)]

  [rand     ? question-icon]

  [red            R (square 32 'solid 'red)]
  [orange         O (square 32 'solid 'orange)]
  [yellow         Y (square 32 'solid 'yellow)]
  [green          G (square 32 'solid 'green)]
  [blue           B (square 32 'solid 'blue)]
  [purple         P (square 32 'solid 'purple)])

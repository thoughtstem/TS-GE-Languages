#lang racket

(require ratchet)

(define-ratchet-lang 
  (provide 
    (all-from-out racket) 
    (all-from-out healer-sea-lib)
    (all-from-out animal-assets))

  (require racket 
           animal-assets 
           healer-sea-lib 
           (only-in 2htdp/image square))

  #:wrapper launch-game-engine


  [start       x play-icon]

  [yellow-fish y (draw-sprite yellow-fish)]
  [green-fish  g (draw-sprite green-fish)]
  [red-fish    r (draw-sprite red-fish)]
  [crab        c (draw-sprite crab)]
  [starfish    s (draw-sprite starfish)]

  [pineapple p (draw-sprite pineapple)]
  [broccoli  b (draw-sprite broccoli)]
  [kiwi      k (draw-sprite kiwi)]
  [tomato    t (draw-sprite tomato)]
  [apple     a (draw-sprite apple)]

  [red    R (square 32 'solid 'red)]
  [orange O (square 32 'solid 'orange)]
  [yellow Y (square 32 'solid 'yellow)]
  [green  G (square 32 'solid 'green)]
  [blue   B (square 32 'solid 'blue)]
  [purple P (square 32 'solid 'purple)]

  [rand     ? question-icon]

  )

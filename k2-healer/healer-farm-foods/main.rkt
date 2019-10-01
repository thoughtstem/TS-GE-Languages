#lang racket

(require ratchet)

(define-ratchet-lang 
  (provide 
    (all-from-out racket) 
    (all-from-out healer-farm-lib)
    (all-from-out animal-assets))

  (require racket 
           animal-assets 
           healer-farm-lib)

  #:wrapper launch-game-engine

  [start    = play-icon]    

  [chicken  c (draw-sprite chicken)]
  [llama    l (draw-sprite llama)]
  [horse    h (draw-sprite horse)]
  [rabbit   r (draw-sprite rabbit)]

  [apple    a (draw-sprite apple)]
  [broccoli b (draw-sprite broccoli)]
  [grapes   g (draw-sprite grapes)]
  [onion    o (draw-sprite onion)]
  [potato   p (draw-sprite potato)]
  [tomato   t (draw-sprite tomato)]

  [rand     ? question-icon])

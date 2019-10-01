#lang racket

(require ratchet)

(define-ratchet-lang
  (provide
    (all-from-out racket)
    (all-from-out clicker-lib)
    (all-from-out animal-assets))

  (require racket
           animal-assets
           clicker-lib
           (only-in 2htdp/image overlay square)
           (only-in pict pict->bitmap)
           )

  #:wrapper launch-game-engine

  [start-forest F (overlay (pict->bitmap play-outline-icon) 
                           (bg->play-icon FOREST-BG))]

  [start-desert D (overlay (pict->bitmap play-outline-icon) 
                           (bg->play-icon DESERT-BG))]

  [start-snow S (overlay (pict->bitmap play-outline-icon)   
                         (bg->play-icon SNOW-BG))]

  [start-lava L (overlay (pict->bitmap play-outline-icon)   
                         (bg->play-icon LAVA-BG))]

  [start-pink P (overlay (pict->bitmap play-outline-icon)   
                         (bg->play-icon PINK-BG))]

  [pointer    p (draw-sprite pointer)]
  [cage       c (draw-sprite cage)]
  [magic-wand m (draw-sprite magic-wand)]
  [glove      g (draw-sprite glove)]
  [white-hand w (draw-sprite white-hand)]

  [dog      d (draw-sprite dog)]
  [horse    h (draw-sprite horse)]
  [rabbit   r (draw-sprite rabbit)]
  [turkey   t (draw-sprite turkey)]

  [apple      a (draw-sprite apple)]
  [banana     b (draw-sprite banana)]
  [kiwi       k (draw-sprite kiwi)]

  [freeze    f (draw-sprite freeze)]
  [slow      s (draw-sprite slow)]
  [light     l (draw-sprite light)]

  ;Colors
  [red            R (square 32 'solid 'red)]
  [orange         O (square 32 'solid 'orange)]
  [yellow         Y (square 32 'solid 'yellow)]
  [green          G (square 32 'solid 'green)]
  [blue           B (square 32 'solid 'blue)]
  [purple         P (square 32 'solid 'purple)]


  [rand     ? question-icon]  

  )

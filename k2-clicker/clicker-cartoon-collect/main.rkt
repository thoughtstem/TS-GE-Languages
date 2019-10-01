#lang racket

(require ratchet)

(define-ratchet-lang
  (provide
    (all-from-out "./start.rkt")
    (all-from-out "./assets.rkt")
    (all-from-out racket)
    (all-from-out clicker-lib)
    (all-from-out animal-assets) 
    (all-from-out cartoon-assets))

  (require racket
           (only-in cartoon-assets cherry FOREST-BG)
           animal-assets
           (except-in clicker-lib FOREST-BG start-forest)
           "./start.rkt"
           "./assets.rkt"
           (only-in 2htdp/image overlay)
           (only-in pict pict->bitmap))

  #:wrapper launch-game-engine

  [start-forest F (overlay (pict->bitmap play-outline-icon) 
                           (bg->play-icon FOREST-BG))]

  [start-desert D (overlay (pict->bitmap play-outline-icon) 
                           (bg->play-icon DESERT-BG))]

  [hammer     p (draw-sprite hammer)]
  [cage       c (draw-sprite cage)]
  [meteor     m (draw-sprite meteor)]
  [glove      g (draw-sprite glove)]
  [white-hand w (draw-sprite white-hand)]

  [tri          d (draw-sprite tri)]
  [bat          h (draw-sprite bat)]
  [bee          r (draw-sprite bee)]
  [red-eye      x (draw-sprite red-eye)]

  [cherry     a (draw-sprite cherry)]
  [star       k (draw-sprite star)]

  [freeze    f (draw-sprite freeze)]
  [slow      s (draw-sprite slow)]
  [light     l (draw-sprite light)]

  [rand     ? question-icon]  

  )

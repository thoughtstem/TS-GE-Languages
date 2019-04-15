#lang racket


(provide (all-from-out "../animal/animal-lang.rkt")
         (all-from-out "../animal/animal-asset-friendly-names.rkt"  ))

(require "../animal/animal-lang.rkt"
         "../animal/animal-asset-friendly-names.rkt")

(module reader syntax/module-reader
  k2/lang/sea/sea-foods-lang)

(module ratchet racket
  
  (require ratchet
           (rename-in "../animal/animal-lang.rkt" 
	              [start-sea-a start])
           "../icons.rkt"
           "../animal/animal-asset-friendly-names.rkt"
           (prefix-in s: survival)
           (prefix-in h: 2htdp/image))

  (define l
    (list yellow-fish green-fish red-fish crab starfish pineapple
          broccoli kiwi tomato apple))
  
  (define rand
    (list-ref l (random 0 6)))

  (define-visual-language sea-lang
    "../animal/animal-lang.rkt"

    [start       x play-icon]

    [yellow-fish y (s:scale-to-fit (s:draw-sprite yellow-fish) 32)]
    [green-fish  g (s:scale-to-fit (s:draw-sprite green-fish)  32)]
    [red-fish    r (s:scale-to-fit (s:draw-sprite red-fish)    32)]
    [crab        c (s:scale-to-fit (s:draw-sprite crab)        32)]
    [starfish    s (s:scale-to-fit (s:draw-sprite starfish)    32)]

    [pineapple p (s:scale-to-fit (s:draw-sprite pineapple) 32)]
    [broccoli  b (s:scale-to-fit (s:draw-sprite broccoli)  32)]
    [kiwi      k (s:scale-to-fit (s:draw-sprite kiwi)      32)]
    [tomato    t (s:scale-to-fit (s:draw-sprite tomato)    32)]
    [apple     a (s:scale-to-fit (s:draw-sprite apple)     32)]

    [rand     ? question-icon]
    ))





#lang racket


(provide (all-from-out "../animal/animal-lang.rkt")
         (all-from-out "../animal/animal-asset-friendly-names.rkt")
         (rename-out [start-sea-npc start])
         rand)

(require "../animal/animal-lang.rkt"
         "../animal/animal-asset-friendly-names.rkt")

(module reader syntax/module-reader
  k2/lang/sea/friends)

(define rand
  (lambda () (first (shuffle (list shark ghost-fish red-fish orange-fish jellyfish octopus
                                   crab green-fish yellow-fish starfish
                                   apple broccoli kiwi mushroom pineapple)))))

(module ratchet racket
  
  (require ratchet
           (rename-in "../animal/animal-lang.rkt" 
	              [start-sea-npc start])
           "../icons.rkt"
           "../animal/animal-asset-friendly-names.rkt"
           (prefix-in s: survival)
           (prefix-in h: 2htdp/image))

  (define rand
    (lambda () (first (shuffle (list shark ghost-fish red-fish orange-fish jellyfish octopus
                                     crab green-fish yellow-fish starfish
                                     apple broccoli kiwi mushroom pineapple)))))


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
    [green-fish  n (s:scale-to-fit (s:draw-sprite green-fish)  32)]
    [yellow-fish y (s:scale-to-fit (s:draw-sprite yellow-fish) 32)]
    [starfish    h (s:scale-to-fit (s:draw-sprite starfish)    32)]
    
    [apple       a (s:scale-to-fit (s:draw-sprite apple)       32)]
    [broccoli    b (s:scale-to-fit (s:draw-sprite broccoli)    32)]
    [kiwi        k (s:scale-to-fit (s:draw-sprite kiwi)        32)]
    [mushroom    m (s:scale-to-fit (s:draw-sprite mushroom)    32)]
    [pineapple   p (s:scale-to-fit (s:draw-sprite pineapple)   32)]

    [rand     ? question-icon]
    ))





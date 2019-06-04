#lang racket


(provide (all-from-out "../animal/animal-lang.rkt")
         (all-from-out "../animal/animal-asset-friendly-names.rkt"  )
         (rename-out [start-sea start])
         rand)

(require "../animal/animal-lang.rkt"
         "../animal/animal-asset-friendly-names.rkt")

(define rand
  (lambda () (first (shuffle (list shark ghost-fish jellyfish octopus
                                   pineapple broccoli kiwi tomato
                                   copper silver gold)))))

(module reader syntax/module-reader
  k2/lang/sea/coins)

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
    (lambda () (first (shuffle (list shark ghost-fish jellyfish octopus
                                     pineapple broccoli kiwi tomato
                                     copper silver gold)))))

  (define-visual-language #:wrapper launch-for-ratchet
                          sea-lang
                          "../animal/animal-lang.rkt"

                          [start       x play-icon]

                          [shark      s (s:scale-to-fit (s:draw-sprite shark)      32)]
                          [ghost-fish g (s:scale-to-fit (s:draw-sprite ghost-fish) 32)]
                          [jellyfish  j (s:scale-to-fit (s:draw-sprite jellyfish)  32)]
                          [octopus    o (s:scale-to-fit (s:draw-sprite octopus)    32)]

                          [pineapple  p (s:scale-to-fit (s:draw-sprite pineapple)  32)]
                          [broccoli   b (s:scale-to-fit (s:draw-sprite broccoli)   32)]
                          [kiwi       k (s:scale-to-fit (s:draw-sprite kiwi)       32)]
                          [tomato     t (s:scale-to-fit (s:draw-sprite tomato)     32)]

                          [copper     1 (s:scale-to-fit (s:draw-sprite copper)     32)]
                          [silver     2 (s:scale-to-fit (s:draw-sprite silver)     32)]
                          [gold       3 (s:scale-to-fit (s:draw-sprite gold)       32)]

                          [red    R (h:square 32 'solid 'red)]
                          [orange O (h:square 32 'solid 'orange)]
                          [yellow Y (h:square 32 'solid 'yellow)]
                          [green  G (h:square 32 'solid 'green)]
                          [blue   B (h:square 32 'solid 'blue)]
                          [purple P (h:square 32 'solid 'purple)]

                          [rand     ? question-icon]
                          ))





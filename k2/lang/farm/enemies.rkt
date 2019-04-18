#lang racket

(provide (all-from-out "../animal/animal-lang.rkt"
                       "../animal/animal-asset-friendly-names.rkt")
         (rename-out [start-c start])
         rand)

(require "../animal/animal-lang.rkt"
         "../animal/animal-asset-friendly-names.rkt")

(define rand
  (lambda () (first (shuffle (list llama horse cow rabbit sheep dog wolf)))))

(module reader syntax/module-reader
  k2/lang/farm/enemies)

(module ratchet racket
  
  (require ratchet
           (rename-in "../animal/animal-lang.rkt" 
                      [start-c start])
           "../icons.rkt"
           "../animal/animal-asset-friendly-names.rkt"
           (prefix-in s: survival)
           (prefix-in h: 2htdp/image))

  (define rand
    (lambda () (first (shuffle (list llama horse cow rabbit sheep dog wolf)))))

  (define-visual-language farm-lang "../animal/animal-lang.rkt" 
    [start    x play-icon]
    
    [llama    l (s:scale-to-fit (s:draw-sprite llama)  32)]
    [horse    h (s:scale-to-fit (s:draw-sprite horse)  32)]
    [cow      c (s:scale-to-fit (s:draw-sprite cow)    32)]
    [rabbit   r (s:scale-to-fit (s:draw-sprite rabbit) 32)]
    [sheep    s (s:scale-to-fit (s:draw-sprite sheep)  32)]
    [dog      d (s:scale-to-fit (s:draw-sprite dog)    32)]
    [wolf     w (s:scale-to-fit (s:draw-sprite wolf)   32)]
    
    [apple    a (s:scale-to-fit (s:draw-sprite apple)  32)]
    [grapes   g (s:scale-to-fit (s:draw-sprite grapes) 32)]
    [kiwi     k (s:scale-to-fit (s:draw-sprite kiwi)   32)]
    [pepper   p (s:scale-to-fit (s:draw-sprite pepper) 32)]

    [copper   1 (s:scale-to-fit (s:draw-sprite copper) 32)]
    [silver   2 (s:scale-to-fit (s:draw-sprite silver) 32)]
    [gold     3 (s:scale-to-fit (s:draw-sprite gold)   32)]

    [rand     ? question-icon]

    ))



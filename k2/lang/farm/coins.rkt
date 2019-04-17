#lang racket

(provide (all-from-out "../animal/animal-lang.rkt"
                       "../animal/animal-asset-friendly-names.rkt")
         (rename-out [start-b start]))

(require "../animal/animal-lang.rkt"
         "../animal/animal-asset-friendly-names.rkt")

(module reader syntax/module-reader
  k2/lang/farm/coins)

(module ratchet racket

  (require ratchet
           (rename-in "../animal/animal-lang.rkt" 
                      (start-b start))
           "../icons.rkt"
           "../animal/animal-asset-friendly-names.rkt"
           (prefix-in s: survival)
           (prefix-in h: 2htdp/image))

  (define l (list llama apple banana potato kiwi copper silver gold))
  
  (define rand
    (list-ref l (random 0 8)))
  
  (define-visual-language farm-lang
    "../animal/animal-lang.rkt" 
    [start    x play-icon]
    
    [llama    l (s:scale-to-fit (s:draw-sprite llama)  32)]
    [cow      c (s:scale-to-fit (s:draw-sprite cow)    32)]
    [rabbit   r (s:scale-to-fit (s:draw-sprite rabbit) 32)]
    [sheep    s (s:scale-to-fit (s:draw-sprite sheep)  32)]
    
    [apple    a (s:scale-to-fit (s:draw-sprite apple)  32)]
    [banana   b (s:scale-to-fit (s:draw-sprite banana) 32)]
    [potato   p (s:scale-to-fit (s:draw-sprite potato) 32)]
    [kiwi     k (s:scale-to-fit (s:draw-sprite kiwi)   32)]

    [copper   1 (s:scale-to-fit (s:draw-sprite copper) 32)]
    [silver   2 (s:scale-to-fit (s:draw-sprite silver) 32)]
    [gold     3 (s:scale-to-fit (s:draw-sprite gold)   32)]

    [rand     ? question-icon]

    ))



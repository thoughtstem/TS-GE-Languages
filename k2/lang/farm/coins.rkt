#lang racket

(provide (all-from-out "../animal/animal-lang.rkt"
                       "../animal/animal-asset-friendly-names.rkt")
         (rename-out [start-animal start])
         rand)

(require "../animal/animal-lang.rkt"
         "../animal/animal-asset-friendly-names.rkt")

(define rand
  (lambda () (first (shuffle (list llama apple banana potato kiwi copper silver gold)))))

(module reader syntax/module-reader
  k2/lang/farm/coins)

(module ratchet racket

  (require ratchet
           ratchet/util
           (rename-in "../animal/animal-lang.rkt" 
                      (start-animal start))
           "../icons.rkt"
           "../animal/animal-asset-friendly-names.rkt"
           (prefix-in s: survival)
           (prefix-in h: 2htdp/image))

  (define rand
    (lambda () (first (shuffle (list llama apple banana potato kiwi copper silver gold)))))
  
  (define-visual-language #:wrapper launch-for-ratchet
                          farm-lang
                          "../animal/animal-lang.rkt" 
                          [start    = play-icon]

                          [llama    l (s:scale-to-fit (s:draw-sprite llama)  32)]
                          [cow      c (s:scale-to-fit (s:draw-sprite cow)    32)]
                          [rabbit   r (s:scale-to-fit (s:draw-sprite rabbit) 32)]
                          [sheep    s (s:scale-to-fit (s:draw-sprite sheep)  32)]

                          [apple    a (s:scale-to-fit (s:draw-sprite apple)  32)]
                          [banana   b (s:scale-to-fit (s:draw-sprite banana) 32)]
                          [potato   p (s:scale-to-fit (s:draw-sprite potato) 32)]
                          [kiwi     k (s:scale-to-fit (s:draw-sprite kiwi)   32)]

                          [copper   x (s:scale-to-fit (s:draw-sprite copper) 32)]
                          [silver   y (s:scale-to-fit (s:draw-sprite silver) 32)]
                          [gold     z (s:scale-to-fit (s:draw-sprite gold)   32)]

                          [rand     ? question-icon]

                          ))



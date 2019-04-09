#lang racket

(provide (all-from-out "../animal/animal-lang.rkt")) 

(require "../animal/animal-lang.rkt"
         "../animal/animal-asset-friendly-names.rkt")

(module reader syntax/module-reader
  k2/lang/animal/animal-lang)

(module ratchet racket
  
  (require ratchet
           (rename-in "../animal/animal-lang.rkt" 
                      [start-c start])
           "../icons.rkt"
           "../animal/animal-asset-friendly-names.rkt"
           (prefix-in s: survival)
           (prefix-in h: 2htdp/image))

  (define (crop i)
    (h:crop 0 0 32 32 i))

  (define (crop-left i)
    (define w (h:image-width i))
    (define h (h:image-height i))
    (h:crop (- w 32) 0 w 32 i))

    (define l (list llama horse cow rabbit sheep dog wolf))
  
  (define rand
    (list-ref l (random 0 6)))

  (define-visual-language farm-lang "../animal/animal-lang.rkt" 
    [start  x play-icon]
    
    [llama    l (crop (crop-left (s:render llama)))]
    [horse    h (crop (crop-left (s:render horse)))]
    [cow      c (crop (crop-left (s:render cow)))]
    [rabbit   r (crop (s:render rabbit))]
    [sheep    s (crop (crop-left (s:render sheep)))]
    [dog      d (crop (crop-left (s:render dog)))]
    [wolf     w (crop (crop-left (s:render wolf)))]
    
    [apple    a (crop (s:render apple))]
    [grapes   g (crop (s:render grapes))]
    [kiwi     k (crop (s:render kiwi))]
    [pepper   p (crop (s:render pepper))]

    [copper   1 (crop (s:render copper))]
    [silver   2 (crop (s:render silver))]
    [gold     3 (crop (s:render gold))]

    [rand     ? question-icon]

    ))



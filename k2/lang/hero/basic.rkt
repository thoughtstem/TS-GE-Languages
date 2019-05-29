#lang racket

;This allows the lang to be used as a module:
;  (require k2/lang/ocean/fish)
(provide (all-from-out "./hero-lang.rkt"))
(require "./hero-lang.rkt")

;This allows the lang to be used as a lang
;  #lang k2/lang/hero/fish
(module reader syntax/module-reader
  k2/lang/hero/hero-lang)

;This allows the lang to be used from Ratchet
;  #lang k2/lang/hero/fish
;  ... Then press "Ratchet"
(module ratchet racket
  
  (require ratchet
           "./hero-lang.rkt"
           "../icons.rkt"
           (prefix-in a: battlearena-avengers))

  (define (draw-head sprite)
    (a:crop/align 'center 'top 32 32 (a:draw-sprite sprite)))

  (define-visual-language hero-lang
    "./hero-lang.rkt"
    [start          w play-icon]

    [ironman        i (a:scale-to-fit (draw-head a:ironman-sprite)        32)]
    [blackwidow     b (a:scale-to-fit (draw-head a:blackwidow-sprite)     32)]
    [captainamerica c (a:scale-to-fit (draw-head a:captainamerica-sprite) 32)]      
    [gamora         g (a:scale-to-fit (draw-head a:gamora-sprite)         32)]
    [hulk           u (a:scale-to-fit (draw-head a:hulk-sprite)           32)]
    
    [loki           l (a:scale-to-fit (draw-head a:loki-sprite)           32)]
    [redskull       r (a:scale-to-fit (draw-head a:redskull-sprite)       32)]
    [mandarin       m (a:scale-to-fit (draw-head a:mandarin-sprite)       32)]
    [nebula         n (a:scale-to-fit (draw-head a:nebula-sprite)         32)]
    
    ))
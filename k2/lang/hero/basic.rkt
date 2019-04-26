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

  (define-visual-language hero-lang
    "./hero-lang.rkt"
    [start          w play-icon]
    
    [blackwidow     b (a:scale-to-fit (a:draw-sprite a:blackwidow-sprite)     32)]   
    [gamora         g (a:scale-to-fit (a:draw-sprite a:gamora-sprite)         32)]
    [captainamerica c (a:scale-to-fit (a:draw-sprite a:captainamerica-sprite) 32)]
    [drax           d (a:scale-to-fit (a:draw-sprite a:drax-sprite)           32)]
    [hulk           u (a:scale-to-fit (a:draw-sprite a:hulk-sprite)           32)]
    [ironman        i (a:scale-to-fit (a:draw-sprite a:ironman-sprite)        32)]
    [loki           l (a:scale-to-fit (a:draw-sprite a:loki-sprite)           32)]
    ))
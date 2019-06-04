#lang racket

;This allows the lang to be used as a module:
;  (require k2/lang/ocean/fish)
(provide (all-from-out "./ocean-lang.rkt"))
(require "./ocean-lang.rkt")

;This allows the lang to be used as a lang
;  #lang k2/lang/ocean/fish
(module reader syntax/module-reader
  k2/lang/ocean/ocean-lang)

;This allows the lang to be used from Ratchet
;  #lang k2/lang/ocean/fish
;  ... Then press "Ratchet"
(module editor racket
  (provide (all-from-out ratchet)
           (rename-out [fish2 editor]))
  
  (require ratchet
           ratchet/util
           (submod "./ocean-lang.rkt" ocean-stuff)
           "../icons.rkt"
           (prefix-in p: pict)
           (prefix-in p: pict/flash))

  (define-visual-language fish2
    (submod "./ocean-lang.rkt" ocean-stuff)
    [fish    f red-fish-icon]   ;TODO: Maybe not a red fish...?
    [red     r (p:colorize (p:filled-flash 20 20) "red")]  ;TODO: Get paint bucket for these
    [green   g (p:colorize (p:filled-flash 20 20) "green")]
    [blue    b (p:colorize (p:filled-flash 20 20) "blue")]

    [above   a above-icon]
    [beside  e beside-icon]
    [overlay o overlay-icon]
    [rotate  t rotate-icon]

    ;For simulations later...
    ;[in-tank t circle]
  
    ))



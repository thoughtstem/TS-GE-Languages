#lang racket

;This allows the lang to be used as a module:
;  (require k2/lang/classroom/basic)
(provide (all-from-out "./classroom-lang.rkt"))
(require "./classroom-lang.rkt")

;This allows the lang to be used as a lang
;  #lang k2/lang/classroom/basic
(module reader syntax/module-reader
  k2/lang/classroom/classroom-lang)

;This allows the lang to be used from Ratchet
;  #lang k2/lang/classroom/basic
;  ... Then press "Ratchet"
(module ratchet racket
  
  (require ratchet
           (submod "./classroom-lang.rkt" classroom-stuff)
           "../icons.rkt"
           (prefix-in p: pict)
           (prefix-in p: pict/flash)
           "./asl/abcs.rkt")

  (define-visual-language classroom-lang
    (submod "./classroom-lang.rkt" classroom-stuff)
    [assign    a group-icon]
    [whenever  w brain-icon]
    [see       e eye-icon]
    [hear      h ear-icon]

    [want      n lightbulb-icon]

    ;Outputs!
    [sit       t sit-icon]
    [stand     d stand-icon]
    [turn      u turn-icon]
    [step      p step-icon]
    [say       a mouth-icon]
    [sign      i hand-icon]
    [breathe   b lungs-icon]

    
    [asl:a     A a]
    [asl:b     B b]
    [asl:c     C c]
    [asl:d     D d]
    ;... Add More ...
    ))

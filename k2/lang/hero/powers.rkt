#lang racket

(provide (all-from-out "./hero-lang.rkt"))
(require "./hero-lang.rkt")

(module reader syntax/module-reader
  k2/lang/hero/hero-lang)

(module ratchet racket
  
  (require ratchet
           "./hero-lang.rkt"
           "../icons.rkt"
           (prefix-in a: battlearena-avengers)
           (prefix-in h: 2htdp/image)
           (prefix-in p: pict)
           (prefix-in p: pict/flash))

  (define (crop i-or-s)
    (define i
      (if (a:animated-sprite? i-or-s)
        (a:sprite->sheet i-or-s)
        i-or-s))
    (h:crop 0 0 32 32 i))

  (define-visual-language #:wrapper begin hero-lang
    "./hero-lang.rkt" 
    [start          q play-icon]

    [blackwidow     a (crop a:blackwidow-sheet)]   
    [gamora         s (crop a:gamora-sheet)]
    [captainamerica d (crop a:captainamerica-sheet)]
    [drax           f (crop a:drax-sheet)]
    [hawkeye        g (crop a:hawkeye-sheet)]
    [hulk           h (crop a:hulk-sheet)]
    [ironman        j (crop a:ironman-sheet)]
    [loki           k (crop a:loki-sheet)]

    [hammer         z (crop (a:hammer-sprite "black"))]
    [magic-orb      x (crop a:flame-sprite)]
    [star-bit       c (crop (a:star-bit-sprite "green"))]
    [energy-blast   v (crop (a:energy-blast-sprite "green"))]

    [red            p (p:colorize (p:filled-ellipse 40 40) "red")]
    [orange         o (p:colorize (p:filled-ellipse 40 40) "orange")]
    [yellow         i (p:colorize (p:filled-ellipse 40 40) "yellow")]
    [green          u (p:colorize (p:filled-ellipse 40 40) "green")]
    [blue           y (p:colorize (p:filled-ellipse 40 40) "blue")]
    [purple         t (p:colorize (p:filled-ellipse 40 40) "purple")]
    ))




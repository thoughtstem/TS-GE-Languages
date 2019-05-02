#lang racket

(provide (all-from-out "./hero-lang.rkt"
                       "../animal/animal-asset-friendly-names.rkt") )

(require "./hero-lang.rkt"
         "../animal/animal-asset-friendly-names.rkt")

(module reader syntax/module-reader
  k2/lang/hero/hero-lang)


(module ratchet racket
  
  (require ratchet
           "./hero-lang.rkt"
           "../icons.rkt"
           "../animal/animal-asset-friendly-names.rkt"
           (prefix-in a: battlearena-avengers)
           (prefix-in p: pict))

    (define health "Health")
    (define grow "Grow")
    (define shrink "Shrink")
    (define speed "Speed")
    (define forcefield "Force Field")

  (define-visual-language #:wrapper begin hero-lang
    "./hero-lang.rkt" 
    [start          w play-icon]

    [blackwidow     b (a:scale-to-fit (a:draw-sprite a:blackwidow-sprite)     32)]
    [captainamerica c (a:scale-to-fit (a:draw-sprite a:captainamerica-sprite) 32)]
    [drax           d (a:scale-to-fit (a:draw-sprite a:drax-sprite)           32)]
    [ironman        i (a:scale-to-fit (a:draw-sprite a:ironman-sprite)        32)]
    [thor           t (a:scale-to-fit (a:draw-sprite a:thor-sprite)           32)]

    [loki           l (a:scale-to-fit (a:draw-sprite a:loki-sprite)           32)]
    [malekith       k (a:scale-to-fit (a:draw-sprite a:malekith-sprite) 32)]
    [mandarin       m (a:scale-to-fit (a:draw-sprite a:mandarin-sprite) 32)]
    [nebula         n (a:scale-to-fit (a:draw-sprite a:nebula-sprite)   32)]

    [hammer         h (a:scale-to-fit (a:draw-sprite (a:hammer-sprite "black"))       32)]
    [magic-orb      x (a:scale-to-fit (a:draw-sprite a:flame-sprite)                  32)]
    [star-bit       y (a:scale-to-fit (a:draw-sprite (a:star-bit-sprite "green"))     32)]
    [energy-blast   z (a:scale-to-fit (a:draw-sprite (a:energy-blast-sprite "green")) 32)]
    [randp          ? question-icon]
    
    [red            1 (p:colorize (p:filled-rectangle 40 40) "red")]
    [orange         2 (p:colorize (p:filled-rectangle 40 40) "orange")]
    [yellow         3 (p:colorize (p:filled-rectangle 40 40) "yellow")]
    [green          4 (p:colorize (p:filled-rectangle 40 40) "green")]
    [blue           5 (p:colorize (p:filled-rectangle 40 40) "blue")]
    [purple         6 (p:colorize (p:filled-rectangle 40 40) "purple")]
    [randc          = rainbow-icon]
    
    [health         + health-icon]
    [grow           g grow-icon]
    [shrink         s shrink-icon]
    [speed          p speed-icon]
    [forcefield     f forcefield-icon]
                              
    ))
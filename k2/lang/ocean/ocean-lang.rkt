#lang racket

(module ocean-stuff racket
  (provide fish
           red green blue
           beside above overlay 
           rotate)
  
  (require (prefix-in p: pict)
           ; game-engine
           )


  ;Constructing fishes...
 
  (struct fish-settings (color))

  (define (blue f)
    (f (fish-settings "blue")))
  
  (define (green f)
    (f (fish-settings "green")))

  (define (red f)
    (f (fish-settings "red")))

  (define (fish s)
    (p:standard-fish 100 50
                     #:direction 'right
                     #:color (fish-settings-color s)))


  ;Combining fishes...

  (define (rotate i) (p:rotate i 45))

  (define overlay p:cc-superimpose)
  (define beside  p:hc-append)
  (define above   p:vc-append))


  
(require 'ocean-stuff)
(provide (all-from-out racket 'ocean-stuff))

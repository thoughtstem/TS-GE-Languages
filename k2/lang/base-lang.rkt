#lang racket


(module base-lang racket
  (provide circle
           square
           jack-o-lantern
           random-dude
         
           bigger
           smaller
           rotate
         
           above
           beside
           overlay
         
           red
           green
           blue
           (all-from-out racket))

  (require (prefix-in p: pict))


  (define jack-o-lantern
    (p:jack-o-lantern 20))

  (define circle
    (p:filled-ellipse 20 20))

  (define square
    (p:filled-rectangle 20 20))

  (define (bigger s)
    (p:scale s 2))

  (define (smaller s)
    (p:scale s 0.5))

  (define (rotate s)
    (p:rotate s (/ 3.14 4)))

  (define (above . ss)
    (apply p:vc-append ss))

  (define (beside . ss)
    (apply p:hc-append ss))

  (define (overlay . ss)
    (apply p:cc-superimpose (reverse ss)))

  (define (red s)
    (p:colorize s "red"))

  (define (green s)
    (p:colorize s "green"))

  (define (blue s)
    (p:colorize s "blue")))


(provide (all-from-out 'base-lang))

(require 'base-lang)

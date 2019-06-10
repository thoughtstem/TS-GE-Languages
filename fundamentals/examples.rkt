#lang racket
(require ts-kata-util 2htdp/image)

(define-example-code racket hello-world
  (local-require 2htdp/image)

  (circle 40 'solid 'red))

(define-example-code racket target
  (local-require 2htdp/image)

  (overlay
   (circle 10 'solid 'red)
   (circle 15 'solid 'white)
   (circle 20 'solid 'red)
   (circle 25 'solid 'white)
   (circle 30 'solid 'red)))

#lang at-exp racket

(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual ))

(require ts-kata-util 2htdp/image)

(define/contract/doc (custom-circle #:color (color "red"))
  (->i () (#:color [color string?]) (result image?))
  @{This returns a fixed-size red circle.  But you can customize the color.}
  (circle 40 'solid color))

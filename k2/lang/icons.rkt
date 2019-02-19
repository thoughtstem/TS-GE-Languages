#lang racket

(require pict racket/runtime-path)

(define-runtime-path images "images")

(define-syntax-rule (define/provide id expr ...)
  (begin
    (provide id)
    (define id expr ...)))

(define/provide dictionary-icon
  (bitmap (build-path images "define.png")))

(define/provide square-icon
  (filled-rectangle 10 10))

(define/provide bigger-icon
  (bitmap (build-path images "bigger.png")))

(define/provide rotate-icon
  (bitmap (build-path images "rotate.png")))

(define/provide red-fish-icon
  (standard-fish 15 10
                 #:direction 'right
                 #:color "red"))

(define/provide green-fish-icon
  (standard-fish 15 10
                 #:direction 'right
                 #:color "green"))

(define/provide blue-fish-icon
  (standard-fish 15 10
                 #:direction 'right
                 #:color "blue"))

(define/provide circle-icon
  (filled-ellipse 10 10))

(define/provide smaller-icon
  (hc-append (arrow 5 pi) (arrow 5 pi)))


(define/provide above-icon
  (bitmap (build-path images "above.png")))



(define/provide beside-icon
  (rotate (bitmap (build-path images "above.png"))
          (/ pi 2)))


(define/provide overlay-icon
  (bitmap (build-path images "overlay.png")))

(define/provide jack-o-lantern-icon
  (jack-o-lantern 10))

(define/provide question-mark-icon
  (colorize (text "?") "red"))

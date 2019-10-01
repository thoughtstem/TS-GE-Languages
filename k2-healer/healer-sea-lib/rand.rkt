#lang racket

(provide rand)

(require animal-assets)

(define (rand)
  (first (shuffle (list apple banana grapes onion potato tomato))))


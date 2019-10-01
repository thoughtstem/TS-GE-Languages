#lang racket

(provide rand)

(require animal-assets)

(define (rand)
  (first (shuffle (list chicken llama horse rabbit apple broccoli grapes onion))))


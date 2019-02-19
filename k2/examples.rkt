#lang racket

(require ts-kata-util
         ;Don't require ratchet here, or your docs will not build (racket/gui/base crap)
         k2/lang/ocean/fish)



(define-example-code k2/lang/ocean/fish
  red-fish
  (red fish))

(define-example-code k2/lang/ocean/fish
  blue-fish
  (blue fish))

(define-example-code k2/lang/ocean/fish
  two-fish
  (beside
   (red fish)
   (blue fish)))


(module+ test
  (require ratchet)
  ;TODO: Make some generalization of test-all-examples-as-games
  ;  so we can automatically test all...

  (run-example two-fish)
  (run-example red-fish)
  (run-example blue-fish)

  
  )



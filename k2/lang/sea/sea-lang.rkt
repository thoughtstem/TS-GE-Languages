#lang racket

(module sea-stuff racket
  (require survival)

  (provide start
           fish)

  (define fish (circle 30 'solid 'blue))

  (define (start avatar)
    (survival-game #:avatar (custom-avatar
                             #:sprite avatar)))
 
  
  (define-syntax-rule (top-level lines ...)
    (let ()
      (thread
        (thunk lines ...)) 
      "Please wait...")))

  
(require 'sea-stuff)
(provide (all-from-out racket 'sea-stuff))

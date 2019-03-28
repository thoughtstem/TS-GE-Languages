#lang racket

(module farm-stuff racket

(require survival)

  (provide start
           cat)

  (define cat cat-sprite)
  
  (define (start avatar-sprite)
   (survival-game #:avatar (custom-avatar #:sprite avatar-sprite))
    )
  
  (define-syntax-rule (top-level lines ...)
    (let ()
      (thread
        (thunk lines ...)) 
      "Please wait...")))

  
(require 'farm-stuff)
(provide (all-from-out racket 'farm-stuff))

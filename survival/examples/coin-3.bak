#lang survival

(define-kata-code survival coin-3
  (define (my-coin)
    (custom-coin #:sprite          copper-coin-sprite
                 #:name            "copper coin"
                 #:value           500
                 #:amount-in-world 20))

  (survival-game
   #:avatar     (custom-avatar)
   #:coin-list  (list (my-coin))))
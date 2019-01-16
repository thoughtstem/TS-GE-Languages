#lang survival
(define (my-coin)
 (custom-coin #:sprite          copper-coin-sprite
              #:name            "copper coin"
              #:value           500
              #:amount-in-world 20))

(survival-game
#:avatar     (custom-avatar)
#:coin-list  (list (my-coin)))

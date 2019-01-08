#lang survival
(define (my-coin)
 (custom-coin #:sprite copper-coin-sprite
              #:name   "copper coin"))

(define (special-coin)
 (custom-coin #:sprite          bat-sprite
              #:name            "bat coin"
              #:value           1000
              #:amount-in-world 1
              #:respawn?        #f))

(survival-game
#:avatar     (custom-avatar)
#:coin-list  (list (my-coin)
                   (special-coin)))

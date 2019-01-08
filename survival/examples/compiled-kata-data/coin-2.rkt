#lang survival
(define (my-coin)
 (custom-coin #:value 500))

(survival-game
#:avatar     (custom-avatar)
#:coin-list  (list (my-coin)))

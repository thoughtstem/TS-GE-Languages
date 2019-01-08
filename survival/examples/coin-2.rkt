#lang survival
 
(define-kata-code survival coin-2
  
  (define (my-coin)
    (custom-coin #:value 500))
 
  (survival-game
   #:avatar     (custom-avatar)
   #:coin-list  (list (my-coin))))

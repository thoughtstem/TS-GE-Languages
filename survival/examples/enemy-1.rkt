#lang racket

(require ts-kata-util survival)
 
(define-kata-code survival enemy-1

  (survival-game
   #:avatar     (custom-avatar)
   #:enemy-list (list (custom-enemy))))

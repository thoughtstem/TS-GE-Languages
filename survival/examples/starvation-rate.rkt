#lang racket

(require ts-kata-util survival)
 
(define-kata-code survival starvation-rate
  (survival-game
   #:avatar          (custom-avatar)
   #:starvation-rate 100))

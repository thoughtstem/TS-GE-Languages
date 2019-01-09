#lang racket

(require ts-kata-util survival)

(define-kata-code survival crafter-1

  (survival-game
   #:avatar       (custom-avatar)
   #:crafter-list (list (custom-crafter))))

#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena enemy-2
  (define (my-enemy)
    (custom-enemy #:ai              'easy
                  #:health          200
                  #:shield          100
                  #:amount-in-world 10))

  (boobs-game
   #:enemy-list (list (my-enemy)))
  )

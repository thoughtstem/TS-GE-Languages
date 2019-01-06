#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena enemy-3
  (define (my-enemy)
    (custom-enemy #:sprite          (star 30 'solid 'gold)
                  #:ai              'easy
                  #:health          200
                  #:shield          100
                  #:amount-in-world 10))

  (battle-arena-game
   #:enemy-list (list (my-enemy)))
  )

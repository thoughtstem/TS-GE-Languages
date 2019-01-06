#lang racket
(require ts-kata-util battle-arena)

(define-kata-code battle-arena enemy-1
  (battle-arena-game
   #:enemy-list (list (custom-enemy)))
  )

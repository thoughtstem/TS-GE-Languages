#lang racket
(require ts-kata-util battle-arena)


(define-kata-code battle-arena avatar-1
  (battle-arena-game
   #:avatar (custom-avatar))
  )

#lang battle-arena

(define-kata-code battle-arena avatar-3

  (define (my-avatar)
    (custom-avatar #:sprite (random-character-sprite)))
  
  (battle-arena-game
   #:avatar (my-avatar)))

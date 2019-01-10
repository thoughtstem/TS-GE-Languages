#lang battle-arena
(define (my-avatar)
 (custom-avatar #:sprite (random-character-sprite)))

(battle-arena-game
#:avatar (my-avatar))

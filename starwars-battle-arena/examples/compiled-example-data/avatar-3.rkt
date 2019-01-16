#lang starwars-battle-arena
(define (my-avatar)
 (custom-jedi #:sprite (random-character-sprite)))

(starwars-game
#:avatar (my-avatar))


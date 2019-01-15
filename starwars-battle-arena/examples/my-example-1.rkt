#lang racket

(require ts-kata-util
  ;You probably want to require your language here...
  starwars-battle-arena)

;And you probably want your lang, not racket below.
;  But technically you can make examples for any language
(define-example-code racket my-example-1
   (starwars-game #:avatar (custom-jedi)))

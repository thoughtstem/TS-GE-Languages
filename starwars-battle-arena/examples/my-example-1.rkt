#lang racket

(require ts-kata-util
         starwars-battle-arena)


(with-mappings-from starwars-battle-arena/mappings
  
  (define-example-code/from*
    battle-arena
    starwars-battle-arena))

(define-run:*)


#lang racket

(require ts-kata-util
         starwars-battle-arena)

<<<<<<< HEAD

(require (prefix-in map: starwars-battle-arena/mappings))

#;(with-substitutions-from (submod starwars-battle-arena 'mappings)
    (define-example-code/from* battle-arena))
=======


;Okay this would kind of work,
;  But if we rely on string pairs, we can't
;  target identifiers that are the same, but mean
;  something different in different contexts...
;Might be find as long as we hide what's happening
;  so we can change it later...
#;(examples-with-substitutions 'battle-arena
                               '(("battle-arena-game"
                                  "starwars-game")))


(define-example-code/from battle-arena
  avatar-1)


;(define-example-code racket my-example-1
;   (starwars-game #:avatar (custom-jedi)))








>>>>>>> c1988514df902bddd24b5c5732875242ba02494c


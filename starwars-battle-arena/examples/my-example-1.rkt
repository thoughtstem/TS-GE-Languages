#lang racket

(require ts-kata-util
  starwars-battle-arena)



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










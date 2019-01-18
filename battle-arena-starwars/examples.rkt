#lang racket

(require ts-kata-util
         battle-arena-starwars)

(require battle-arena-starwars/mappings)

(define syntax:avatar-1
  #'(begin
      (custom-avatar)
      (begin (custom-avatar))
      (battle-arena-game
       #:avatar
       (custom-avatar)

       )))


(require macro-debugger/expand)

(define my-expand
  (curryr expand-only (list
                       #'custom-avatar
                       #'battle-arena-game
                            )))

(my-expand syntax:avatar-1)



;(map:custom-avatar syntax:avatar-1)

#;(define-example-code battle-arena-starwars avatar-1
    (battle-arena-game
     #:avatar (custom-avatar)))


#;(define-example-code/from*
    battle-arena
    battle-arena-starwars)

;(define-run:*)


#lang racket

(module zoo-stuff racket
  (require survival)

  (provide start zookeeper tiger panther)

  (define zookeeper mystery-sprite)
  
  (define tiger (custom-npc #:sprite cat-sprite
                            #:dialog (list "RaawWRR!")
                            #:components (hidden)
                                         (on-start (do-many (active-on-random)
                                                            show))))
  
  (define panther (custom-npc #:sprite black-cat-sprite
                              #:dialog (list "RaAaWWwrRR!")
                              #:components (hidden)
                                           (on-start (do-many (active-on-random)
                                                              show))))

  (define (start avatar-sprite . npcs)
    (survival-game #:bg (custom-bg #:rows 2
                                   #:columns 2)
                   #:avatar (custom-avatar #:sprite avatar-sprite)
                   #:starvation-rate -5000
                   #:npc-list npcs))
  
  (define-syntax-rule (top-level lines ...)
    (let ()
      (thread
        (thunk lines ...)) 
      "Please wait...")))

  
(require 'zoo-stuff)
(provide (all-from-out racket 'zoo-stuff))

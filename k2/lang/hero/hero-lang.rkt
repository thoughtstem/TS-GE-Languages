#lang racket

(module hero-stuff racket
  (provide (all-from-out battle-arena-avengers/assets)
           start)
  
  (require battle-arena-avengers
           battle-arena-avengers/assets)

  (define (start . is)
    (define sprites 
      (map (lambda(i) (sheet->sprite i #:rows 4 #:columns 4 #:row-number 3 #:delay 5)) is)) 

    (define villains
      (map (λ(s) (custom-villain #:sprite s))
           (rest sprites)))
    
    (thread (thunk
             (avengers-game #:hero (custom-hero #:sprite (first sprites))
                            #:villain-list villains)))

    "Please wait... (Take about 10 deep breaths...)" ))


  
(require 'hero-stuff)
(provide (all-from-out racket 'hero-stuff))

#lang battle-arena

(define-kata-code battle-arena spear-3
  (define (my-spear)
    (spear #:damage     25
           #:durability 10))
  
  (define (my-weapon-1)
    (custom-weapon #:name   "Spear"
                   #:sprite STUDENT-IMAGE-HERE
                   #:dart   (my-spear)
                   #:rarity 'common))
  
  (battle-arena-game
   #:weapon-list (list (my-weapon-1)))
  )

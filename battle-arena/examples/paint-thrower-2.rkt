#lang battle-arena


(define-kata-code battle-arena paint-thrower-2
  (define (my-weapon-3)
    (custom-weapon #:name   "Paint Thrower"
                   #:sprite PAINT-THROWER-ICON
                   #:dart   (paint)
                   #:rarity 'epic))
  
  (battle-arena-game
   #:weapon-list (list (my-weapon-3)))
  )

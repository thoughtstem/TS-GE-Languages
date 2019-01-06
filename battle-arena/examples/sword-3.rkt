#lang racket
(require ts-kata-util battle-arena)



(define-kata-code battle-arena sword-3

  (define (my-sword)
    (sword #:damage     50
           #:durability 20))
  
  (define (my-weapon-2)
    (custom-weapon #:name   "Sword"
                   #:sprite STUDENT-IMAGE-HERE
                   #:dart   (my-sword)))
  
  (battle-arena-game
   #:weapon-list (list (my-weapon-2))))

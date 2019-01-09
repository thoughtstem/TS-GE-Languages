#lang racket

(require ts-kata-util survival)

(define-kata-code survival enemy-3

  (define (my-weapon)
    (custom-weapon #:name "Acidtron"
                   #:dart (custom-dart #:damage 50
                                       #:speed  20)))
 
  (define (my-enemy)
    (custom-enemy #:ai              'medium
                  #:sprite          bat-sprite
                  #:amount-in-world 5
                  #:weapon          (my-weapon)))
 
  (survival-game
   #:avatar     (custom-avatar)
   #:enemy-list   (list (my-enemy))))

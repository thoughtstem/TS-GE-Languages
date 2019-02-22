#lang racket

(module classroom-stuff racket
  (provide (struct-out hear)
           (struct-out see)
           (struct-out say)
           (struct-out sign)
           (struct-out whenever)
           (struct-out assign)
           (struct-out want)

           (struct-out sit)
           (struct-out stand)
           (struct-out turn)
           (struct-out step)
           (struct-out breathe)
           
           (prefix-out asl: (all-from-out "./asl/abcs.rkt")))
  
  (require "./asl/abcs.rkt")

  (struct assign   (programs)  #:transparent)
  (struct whenever (in out)    #:transparent)
  (struct hear     (something) #:transparent)
  (struct see      (something) #:transparent)
  (struct want     ()          #:transparent)
  
  (struct say      (something) #:transparent)
  (struct sign     (something) #:transparent)

  (struct sit      () #:transparent)
  (struct stand    () #:transparent)

  (struct turn     (amount) #:transparent)
  (struct step     (amount) #:transparent)
  (struct breathe  (amount) #:transparent))


(require 'classroom-stuff)
(provide (all-from-out racket 'classroom-stuff))


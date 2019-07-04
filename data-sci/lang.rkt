#lang at-exp racket

(provide
 (all-from-out "./lang/main.rkt")

 #;
 (all-from-out "./lang/corpus/main.rkt")
 (all-from-out "./assets.rkt")
 (all-from-out pict)
 (all-from-out plot)
 (all-from-out racket)
 #%module-begin)

(require pict)
(require plot)
(require "./lang/main.rkt")
(require "./assets.rkt")

#;
(require (except-in "./lang/corpus/main.rkt"
                    scale))


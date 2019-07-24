#lang racket

(module reader syntax/module-reader
   data-sci)

(provide
 (all-from-out "./lang/main.rkt")
 (all-from-out pict)
 (all-from-out plot)
 (all-from-out racket)
 #%module-begin)

(require pict plot "./lang/main.rkt")


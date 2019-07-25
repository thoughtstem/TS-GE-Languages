#lang racket/base

(provide zip 
         cluster
         data-set 
         (all-from-out "../sets.rkt"))

(require plot 
         racket/runtime-path
         data-science
         "../sets.rkt"
         "./k-means.rkt")

(define (zip l1 l2)
  (map list l1 l2))


;A hook for if we want to do some kind of dynamic requiring of datasets.
(define (data-set f)
  (f))

;Data sets ideas...


;Sports stats...

;Tweet corpuses...

;Stock market stuff

;TS computers on the network...
  ;Coding stats... 

;Katas, collections and their length..

;Katas, corpuses and their vocabulary

;Trending memes

;Weather data

;Countries and populations
;States and populations
;Gun violence data
;Racial inequality data

;Flu spread data


;Google trends data  


;Salaries across different fields

;Happiness data


























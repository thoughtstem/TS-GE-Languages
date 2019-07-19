#lang at-exp racket

(provide zip data-set (all-from-out "../sets.rkt"))

(require scribble/srcdoc)
(require (for-doc racket/base scribble/manual))

(require ts-kata-util
         plot 
         racket/runtime-path
         data-science
         "../sets.rkt")

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



























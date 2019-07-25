#lang racket

(provide
  titanic
  titanic-raw-data

  titanic-row-survived?
  titanic-row-name
  titanic-row-age)


(require csv-reading
         racket/runtime-path
         "./csv-util.rkt")

(define-runtime-path here ".")


(define (titanic-raw-data)
  (csv->list-of-lists 
    (build-path here 
                "./dumps/titanic.csv")))

(define (titanic)
  (define d (drop (titanic-raw-data) 1)) 

  (map row-strings->numbers d))

(define (row-strings->numbers r)
  (define (maybe-numberize s)
    (define number? (string->number s))
    (or number? s))

  (map maybe-numberize r))

(define (titanic-row-survived? r)
  (= (first r) 1))

(define (titanic-row-name r)
  (third r))

(define (titanic-row-age r)
  (fifth r))

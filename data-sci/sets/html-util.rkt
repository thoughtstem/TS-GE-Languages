#lang racket

(provide td? tr? a? 
         collect-tag)

(define (td? xexpr)
  (eq? 'td (first xexpr)))

(define (tr? xexpr)
  (eq? 'tr (first xexpr)))

(define (a? xexpr)
  (eq? 'a (first xexpr)))

(define (collect-tag t?)
  (and/c (not/c empty) list? t?))


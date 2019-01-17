#lang info

(define scribblings 
  '(("scribblings/manual.scrbl" ())))

(define deps '(
  "battle-arena"
  "ts-kata-util"))

(define compile-omit-paths '(
  "examples"))

(define test-omit-paths '("examples/compiled-kata-data" "examples/compiled-example-data"))

(define test-include-paths '( "examples/*.rkt"))

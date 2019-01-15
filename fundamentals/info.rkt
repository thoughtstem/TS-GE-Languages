#lang info

(define scribblings 
  '(("scribblings/manual.scrbl" ())))

(define deps '(
  "https://github.com/thoughtstem/TS-Kata-Collections.git?path=ts-kata-util"))

(define compile-omit-paths '(
  "examples"))

(define test-omit-paths '("examples/compiled-kata-data"))

(define test-include-paths '( "examples/*.rkt"))

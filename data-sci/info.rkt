#lang info

(define scribblings 
  '(("scribblings/manual.scrbl" ())))

(define deps '(
  "https://github.com/thoughtstem/TS-Kata-Collections.git?path=ts-kata-util"
  "https://github.com/n3mo/data-science.git"
  ))

(define compile-omit-paths '(
  "examples.rkt"))

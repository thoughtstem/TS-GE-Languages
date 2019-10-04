#lang info

(define scribblings 
  '(("scribblings/manual.scrbl" ())))

(define deps '(
  "https://github.com/thoughtstem/TS-GE-Katas.git?path=ts-kata-util"
  "https://github.com/thoughtstem/TS-GE-Languages.git?path=survival"
  ))

(define compile-omit-paths'(
                            "examples.rkt"))


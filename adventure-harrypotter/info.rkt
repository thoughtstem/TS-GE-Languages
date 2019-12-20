#lang info

(define scribblings 
  '(("scribblings/manual.scrbl" ())))

(define deps '(
  "https://github.com/thoughtstem/TS-Kata-Collections.git?path=ts-kata-util"
  "https://github.com/thoughtstem/TS-Languages.git?path=adventure"
  "https://github.com/thoughtstem/fandom-sprites.git"
  ))

(define compile-omit-paths '(
  "examples.rkt"))

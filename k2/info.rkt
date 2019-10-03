#lang info

(define scribblings 
  '(("scribblings/manual.scrbl" ())))

(define deps '(
  "https://github.com/thoughtstem/TS-Kata-Collections.git?path=ts-kata-util"
  "battlearena-avengers"
  "survival"
  "ratchet"
  ))

(define compile-omit-paths '(
  "examples.rkt"))

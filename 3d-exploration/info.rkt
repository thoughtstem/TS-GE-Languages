#lang info

(define scribblings '(("scribblings/manual.scrbl" (multi-page))))

(define deps '(
  "https://github.com/thoughtstem/TS-Kata-Collections.git?path=ts-kata-util"
  "https://github.com/thoughtstem/vr-engine.git"
  ))

(define compile-omit-paths '(
  "examples.rkt"))


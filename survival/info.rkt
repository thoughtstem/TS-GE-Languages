#lang info

(define scribblings '(("scribblings/manual.scrbl" (multi-page))))

(define deps '(
  "https://github.com/thoughtstem/ts-kata-util.git"
  "https://github.com/thoughtstem/game-engine.git"
  "https://github.com/thoughtstem/game-engine-rpg.git"
  "https://github.com/thoughtstem/game-engine-demos.git?path=game-engine-demos-common"
  ))

(define compile-omit-paths '(
  "test" "scribblings" "examples/compiled-kata-data"))

(define test-omit-paths '("doc" "scribblings" "jam" "scoring" "examples/compiled-kata-data"))

(define test-include-paths '( "examples/*.rkt"))

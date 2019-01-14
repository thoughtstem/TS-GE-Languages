#lang racket

(require scribble/srcdoc
         scribble/extract)

(require (for-doc racket/base scribble/manual))


;This works, but there are broken links in the docs.
;  For some reason, which I don't understand, Scribble's in-source
;  documentation only works in this main.rkt file.  Doing it
;  in battle-arena-game-jam.rkt (where I want to be doing it),
;  leads to broken links.
;  https://github.com/thoughtstem/TS-Languages/issues/9

(provide-extracted "./jam/survival-game-jam.rkt")

(module reader syntax/module-reader
  survival/jam-lang)

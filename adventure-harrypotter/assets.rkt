#lang at-exp racket

(require ts-kata-util/assets/main
         adventure)

(define-assets-from "assets")

(provide harrypotter-sprite)

(define harrypotter-sprite
  (sheet->sprite harrypotter-sheet
                 #:rows 1
                 #:columns 9
                 #:row-number 1
                 #:delay 5))